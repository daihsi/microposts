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
end
