require 'rails_helper'

RSpec.describe Post do
  let(:user) { create(:user) }

  it '全投稿を取得できているか' do
    posts = []
    10.times { posts.push(create(:post, user_id: user.id)) }
    posts_count = posts.length

    query_string = <<-GRAPHQL
    {     
      posts {
        id
        pid
        content
        userId
      }
    }
    GRAPHQL

    result = MicropostsSchema.execute(query_string, context: {}, variables: {})
    expect(result["data"]["posts"].size).to eq posts_count
  end

  it '指定した投稿を取得できているか' do
    post = create(:post, user_id: user.id)

    query_string = <<-GRAPHQL
      query PostResolver($id: Int = #{post.id.to_i}) {
        post(id: $id) {
          id
          pid
          content
          userId
        }
      }
    GRAPHQL
    result = MicropostsSchema.execute(query_string, context: {}, variables: {})
    expect(result["data"]["post"]["pid"]).to eq post.pid
  end

  describe '投稿CRUDテスト' do
    let(:post) { create(:post, user_id: user.id) }

    it '新規投稿を作成できているか' do
      query_string = <<-GRAPHQL
      mutation CreatePost($input: CreatePostInput!) {
        createPost(input: $input) {
          post {
            id
            pid
            content
            userId
          }
        }
      }
      GRAPHQL
      variables = {
        "input": {
          "userId": user.id,
          "content": Faker::String.random(length: 300)
        }
      }
      result = MicropostsSchema.execute(query_string, context: {}, variables: variables)
      expect(result["data"]["createPost"]["post"].blank?).to eq false
    end

    it '投稿を更新できているか' do
      query_string = <<-GRAPHQL
      mutation UpdatePost($input: UpdatePostInput!) {
        updatePost(input: $input) {
          post {
            id
            pid
            content
            userId
          }
        }
      }
      GRAPHQL
      variables = {
        "input": {
          "id": post.id,
          "content": Faker::String.random(length: 300)
        }
      }
      result = MicropostsSchema.execute(query_string, context: {}, variables: variables)
      expect(result["data"]["updatePost"]["post"]["content"]).to eq variables[:input][:content]
    end

    it '投稿を削除できているか' do
      query_string = <<-GRAPHQL
      mutation DeletePost($input: DeletePostInput!) {
        deletePost(input: $input) {
          post {
            id
            pid
            content
            userId
          }
        }
      }
      GRAPHQL
      variables = {
        "input": {
          "id": post.id,
        }
      }
      MicropostsSchema.execute(query_string, context: {}, variables: variables)
      expect(Post.where(id: post.id).count).to eq 0
    end
  end
end
