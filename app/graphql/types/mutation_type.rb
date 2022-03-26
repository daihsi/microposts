module Types
  class MutationType < Types::BaseObject
    field :unfollowing, mutation: Mutations::Unfollowing
    field :following, mutation: Mutations::Following
    field :delete_comment, mutation: Mutations::DeleteComment
    field :create_comment, mutation: Mutations::CreateComment
    field :delete_post, mutation: Mutations::DeletePost
    field :update_post, mutation: Mutations::UpdatePost
    field :create_post, mutation: Mutations::CreatePost
    field :update_user, mutation: Mutations::UpdateUser
    field :create_user, mutation: Mutations::CreateUser
  end
end
