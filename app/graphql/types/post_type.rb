# frozen_string_literal: true

module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :pid, String, null: false
    field :content, String, null: false
    field :user_id, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user_loader, Types::UserType
    field :comments_loader, [Types::CommentType]
    field :like_users_loader, [Types::LikeType]

    def user_loader
      Loaders::RecordLoader.for(User).load(object.user_id)
    end

    def comments_loader
      Loaders::AssociationLoader.for(Post, :comments).load(object)
    end

    def like_users_loader
      Loaders::AssociationLoader.for(Post, :likes).load(object)
    end
  end
end
