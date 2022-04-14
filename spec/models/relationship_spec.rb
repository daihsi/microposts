require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:current_user) { create(:user) }
  let(:follow_user) { create(:user) }

  describe 'フォロー/アンフォローの検証' do
    it 'フォローが成功しているか' do
      current_user.follow(user_id: follow_user.id)
      expect(current_user.following?(user: follow_user)).to eq true
    end

    it 'アンフォローが成功しているか' do
      current_user.follow(user_id: follow_user.id)
      current_user.unfollow(user_id: follow_user.id)
      expect(current_user.following?(user: follow_user)).to eq false
    end
  end

  describe 'dependent:destroyの検証' do
    it 'ユーザーを削除するとフォローも削除されているか' do
      follow_data = current_user.follow(user_id: follow_user.id)
      User.find_by(id: current_user.id).destroy
      expect(Relationship.find_by(id: follow_data.id).nil?).to eq true
    end
  end
end