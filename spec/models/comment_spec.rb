require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'contentの検証' do
    it 'contentが未入力' do
      comment = build(:comment, content: nil)
      comment.valid?
      expect(comment.errors[:content].first).to include('content.blank')
      expect(comment).not_to be_valid
    end

    it 'contentの桁数がオーバー' do
      MAX_CONTENT_LENGTH = 300
      fake_content = Faker::String.random(length: (MAX_CONTENT_LENGTH + 1))
      comment = build(:comment, content: fake_content)
      comment.valid?
      expect(comment.errors[:content].first).to include('content.too_long')
      expect(comment).not_to be_valid
    end
  end

  describe 'コメントのCRUD検証' do
    let(:comment) { create(:comment) }
    it '新規コメント作成' do
      expect(comment).to be_valid
    end

    it 'コメント削除' do
      comment.destroy
      expect(Comment.find_by(id: comment.id).nil?).to eq true
    end
  end

  describe 'dependent:destroyの検証' do
    let(:comment) { create(:comment) }
    it '投稿を削除すると紐づくコメントも削除されているか' do
      Post.find_by(id: comment.post_id).destroy
      expect(Comment.find_by(id: comment.id).nil?).to eq true
    end

    it 'ユーザーを削除すると紐づくコメントも削除されているか' do
      User.find_by(id: comment.user_id).destroy
      expect(Comment.find_by(id: comment.id).nil?).to eq true
    end
  end
end
