require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'いいねのCRUD検証' do
    it '新規いいね' do
      like = create(:like)
      expect(Like.find_by(id: like.id).nil?).to eq false
    end
    it 'いいね外す' do
      like = create(:like)
      like.destroy
      expect(Like.find_by(id: like.id).nil?).to eq true
    end
  end
  describe 'Likeを介して第三のモデルを取得できるか' do
    let(:like)  { create(:like) }
    it 'ユーザーからいいねした投稿の取得' do
      expect(User.find_by(id: like.user_id).like_posts.nil?).to eq false
    end
    it '投稿からいいねしたユーザーの取得' do
      expect(Post.find_by(id: like.post_id).like_users.nil?).to eq false
    end
  end
  describe 'dependent:destroyの検証' do
    let(:like) { create(:like) }
    it 'ユーザーを削除すると紐づくいいねも削除されているか' do
      User.find_by(id: like.user_id).destroy
      expect(Like.find_by(id: like.id).nil?).to eq true
    end
    it '投稿を削除すると紐づくいいねも削除されているか' do
      Post.find_by(id: like.post_id).destroy
      expect(Like.find_by(id: like.id).nil?).to eq true
    end
  end
  describe 'メソッドの検証' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    it 'like_post メソッド検証' do
      like = user.like_post(post_id: post.id)
      expect(Like.find_by(id: like.id).nil?).to eq false
    end

    it 'unlike_post メソッド検証' do
      like = user.like_post(post_id: post.id)
      user.unlike_post(post_id: post.id)
      expect(Like.find_by(id: like.id).nil?).to eq true
    end

    context 'like_post? メソッド検証' do
      it 'trueの場合' do
        user.like_post(post_id: post.id)
        expect(user.like_post?(post: post)).to eq true
      end

      it 'falseの場合' do
        expect(user.like_post?(post: post)).to eq false
      end
    end
  end
end
