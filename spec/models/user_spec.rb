require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    it '新規登録が成功していること' do
      user = create(:user)
      expect(user).to be_valid
    end
  end

  describe 'nameの検証' do
    it 'nameが未入力' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end
  end

  describe 'emailの検証' do
    it 'emailが未入力' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'emailが不正' do
      user = build(:user, email: 'test')
      expect(user).not_to be_valid
    end

    it 'emailがすでに登録してある' do
      user = create(:user, email: 'test@test.com')
      target_user = build(:user, email: 'test@test.com')
      expect(target_user).not_to be_valid
    end
  end

  describe 'passwordの検証' do
    it 'passwordが未入力' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it 'passwordの桁不足' do
      user = build(:user, password: '111')
      expect(user).not_to be_valid
    end

    it 'password_confirmationが間違えっている' do
      user = build(:user, password: '111１')
      expect(user).not_to be_valid
    end
  end
end
