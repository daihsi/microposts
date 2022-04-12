require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  describe 'contentの検証' do
    it 'contentが未入力' do
      post = build(:post, { content: nil, user_id: user.id })
      post.valid?
      expect(post.errors[:content].first).to include("content.blank")
      expect(post).not_to be_valid
    end

    it 'contentの桁数がオーバー' do
      MAX_CONTENT_LENGTH = 300
      fake_content = Faker::String.random(length: (MAX_CONTENT_LENGTH + 1))
      post = build(:post, { content: "#{fake_content}", user_id: user.id })
      post.valid?
      expect(post.errors[:content].first).to include("content.too_long")
      expect(post).not_to be_valid
    end
  end

  describe '新規投稿' do
    it '新規投稿が成功していること' do
      post = create(:post, user_id: user.id)
      expect(post).to be_valid
    end
  end

end
