require 'rails_helper'

RSpec.describe Comment do
  it '全コメントを取得できているか' do
    comments = []
    10.times { comments.push(create(:comment)) }
    comments_count = comments.length

    query_string = <<-GRAPHQL
    {
      comments {
        id
        postId
        postLoader {
          id
          content
          pid
          userId
          userLoader {
            id
            uid
            name
            email
          }
        }
        userId
        userLoader {
          id
          uid
          name
          email
        }
      }
    }
    GRAPHQL

    result = MicropostsSchema.execute(query_string, context: {}, variables: {})
    expect(result["data"]["comments"].size).to eq comments_count
  end

  it '指定したコメントを取得できているか' do
    comment = create(:comment)
    query_string = <<-GRAPHQL
      query CommentResolver($id: Int = #{comment.id.to_i}) {
        comment(id: $id) {
          id
          postId
          postLoader {
            id
            content
            pid
            userId
            userLoader {
              id
              uid
              name
              email
            }
          }
          userId
          userLoader {
            id
            uid
            name
            email
          }
        }
      }
    GRAPHQL

    result = MicropostsSchema.execute(query_string, context: {}, variables: {})
    expect(result["data"]["comment"]["id"].to_i).to eq comment.id
  end

  describe 'コメントCRUDテスト' do
    let(:comment) { create(:comment) }

    it '新規コメントを削除できているか' do
      query_string = <<-GRAPHQL
        mutation CreateComment($input: CreateCommentInput!) {
          createComment(input: $input) {
            comment {
              id
              postId
              postLoader {
                id
                content
                pid
                userId
                userLoader {
                  id
                  uid
                  name
                  email
                }
              }
              userId
              userLoader {
                id
                uid
                name
                email
              }
            }
          }
        }
      GRAPHQL

      variables = {
        input: {
          userId: comment.user_id,
          postId: comment.post_id,
          content: Faker::String.random(length: 300)
        }
      }
      result = MicropostsSchema.execute(query_string, context: {}, variables: variables)
      expect(Comment.find_by(id: result["data"]["createComment"]["comment"]["id"].to_i).nil?).to eq false
    end

    it 'コメントを削除できているか' do
      query_string = <<-GRAPHQL
        mutation DeleteComment($input: DeleteCommentInput!) {
          deleteComment(input: $input) {
            comment {
              id
              postId
              postLoader {
                id
                content
                pid
                userId
                userLoader {
                  id
                  uid
                  name
                  email
                }
              }
              userId
              userLoader {
                id
                uid
                name
                email
              }
            }
          } 
        }
      GRAPHQL
      variables = {
        input: {
          id: comment.id
        }
      }
      MicropostsSchema.execute(query_string, context: {}, variables: variables)
      expect(Comment.find_by(id: comment.id).nil?).to eq true
    end
  end
end
