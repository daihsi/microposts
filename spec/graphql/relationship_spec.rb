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
end
