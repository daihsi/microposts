require 'rails_helper'

RSpec.describe Like do
  describe 'いいねの取得検証' do
    let(:current_user) { create(:user) }
    let(:post) { create(:post) }
    let(:likes) { [] }

    describe '指定ユーザーのいいねを全件取得できているか' do
      before do
        10.times do
          like = create(:like, { user: current_user, post: post })
          likes.push(like)
        end
      end
      it do
        query_string = <<-GRAPHQL
          query UserResolver($id: Int = #{current_user.id.to_i}) {
            user(id: $id) {
              id
              likePostsLoader {
                id
                likePostLoader {
                  id
                  content
                }
              }
            }
          }
        GRAPHQL
        result = MicropostsSchema.execute(query_string, context: {}, variables: {})
        expect(result["data"]["user"]["likePostsLoader"].size).to eq likes.length
      end
    end

    describe '指定投稿のいいねを全件取得できているか' do
      before do
        10.times do
          like = create(:like, { user: current_user, post: post })
          likes.push(like)
        end
      end
      it do
        query_string = <<-GRAPHQL
          query PostResolver($id: Int = #{post.id.to_i}) {
            post(id: $id) {
              id
              likeUsersLoader {
                id
                likeUserLoader {
                  id
                  email
                  name
                }
              }
            }
          }
        GRAPHQL
        result = MicropostsSchema.execute(query_string, context: {}, variables: {})
        expect(result["data"]["post"]["likeUsersLoader"].size).to eq likes.length
      end
    end
  end

  describe 'いいねのCRUD' do
    let(:current_user) { create(:user) }
    let(:post) { create(:post) }

    it '新規いいね' do
      query_string = <<-GRAPHQL
        mutation LikeCreate($input: LikeCreateInput!) {
          likeCreate(input: $input) {
            like {
              id
              likeUserLoader {
                id
                email
                name
              }
              likePostLoader {
                id
                content
              }
            }
          }
        }
      GRAPHQL

      variables = {
        input: {
          userId: current_user.id,
          postId: post.id
        }
      }

      result = MicropostsSchema.execute(query_string, context: {}, variables: variables)
      expect(result["data"]["likeCreate"]["like"]["likeUserLoader"]["id"].to_i).to eq current_user.id
      expect(result["data"]["likeCreate"]["like"]["likePostLoader"]["id"].to_i).to eq post.id
    end
  end

  describe 'いいねのCRUD' do
    let(:current_user) { create(:user) }
    let(:post) { create(:post) }

    before do
      create(:like, { user: current_user, post: post })
    end

    it 'いいね外す' do
      query_string = <<-GRAPHQL
        mutation LikeDelete($input: LikeDeleteInput!) {
          likeDelete(input: $input) {
            unlike {
              id
              email
              name
              likePostsLoader {
                id
                likePostLoader {
                  id
                  content 
                }
              }
            }
          }
        }
      GRAPHQL

      variables = {
        input: {
          userId: current_user.id,
          postId: post.id
        }
      }

      result = MicropostsSchema.execute(query_string, context: {}, variables: variables)
      expect(result["data"]["likeDelete"]["unlike"]["likePostsLoader"].empty?).to eq true
      expect(Like.find_by(user_id: current_user.id, post_id: post.id).nil?).to eq true
    end
  end
end
