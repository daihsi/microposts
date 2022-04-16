require 'rails_helper'

RSpec.describe Relationship do
  describe 'フォローとフォロワーの取得を検証' do
    let(:current_user) { create(:user) }
    let(:follow_users) { [] }

    describe 'フォローの検証' do
      before do
        10.times do
          follow_user = create(:relationship, follower: current_user)
          follow_users.push(follow_user)
        end
      end
      it '指定ユーザーのフォローを全件取得出来ているか' do
        query_string = <<-GRAPHQL
        query UserResolver($id: Int = #{current_user.id.to_i}) {
          user(id: $id) {
            id
            followedLoader {
              id
              followerId
              followedId
            }
          }
        }
        GRAPHQL
        result = MicropostsSchema.execute(query_string, context: {}, variables: {})
        expect(result["data"]["user"]["followedLoader"].size).to eq follow_users.length
      end
    end

    describe 'フォロワーの検証' do
      before do
        10.times do
          follow_user = create(:relationship, followed: current_user)
          follow_users.push(follow_user)
        end
      end
      it '指定ユーザーのフォロワーを全件取得出来ているか' do
        query_string = <<-GRAPHQL
        query UserResolver($id: Int = #{current_user.id.to_i}) {
          user(id: $id) {
            id
            followerLoader {
              id
              followerId
              followedId
            }
          }
        }
        GRAPHQL
        result = MicropostsSchema.execute(query_string, context: {}, variables: {})
        expect(result["data"]["user"]["followerLoader"].size).to eq follow_users.length
      end
    end
  end

  describe 'フォローとアンフォローの検証' do
    let(:current_user) { create(:user) }
    let(:follow_user) { create(:user) }

    it 'フォローの検証' do
      query_string = <<-GRAPHQL
      mutation Following($input: FollowingInput!) {
        following(input: $input) {
          follow {
            followerLoader {
              id
            }
            followedLoader {
                id
            }
          }
        } 
      }
      GRAPHQL

      variables = {
        input: {
          followerId: current_user.id,
          followedId: follow_user.id
        }
      }
      result = MicropostsSchema.execute(query_string, context: {}, variables: variables)
      expect(result["data"]["following"]["follow"]["followerLoader"]["id"].to_i).to eq current_user.id
      expect(result["data"]["following"]["follow"]["followedLoader"]["id"].to_i).to eq follow_user.id
    end

    describe 'アンフォローの検証' do
      before do
        @follow_data = create(:relationship, { follower: current_user, followed: follow_user })
      end
      it 'アンフォローの検証' do

        query_string = <<-GRAPHQL
        mutation Unfollowing($input: UnfollowingInput!) {
          unfollowing(input: $input) {
            unfollow {
              followerLoader {
                id
              }
              followedLoader {
                id
              }
            }
          } 
        }
        GRAPHQL

        variables = {
          input: {
            followerId: current_user.id,
            followedId: follow_user.id
          }
        }
        result = MicropostsSchema.execute(query_string, context: {}, variables: variables)
        expect(result["data"]["unfollowing"]["unfollow"]["followerLoader"]["id"].to_i).to eq current_user.id
        expect(result["data"]["unfollowing"]["unfollow"]["followedLoader"]["id"].to_i).to eq follow_user.id
        expect(Relationship.find_by(id: @follow_data.id).nil?).to eq true
      end
    end
  end
end
