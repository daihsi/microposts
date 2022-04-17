# frozen_string_literal: true

module Types
  class LikeType < Types::BaseObject
    field :id, ID, null: false
    field :like_user_loader, Types::UserType, null: false
    field :like_post_loader, Types::PostType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def like_user_loader
      Loaders::RecordLoader.for(User).load(object.user_id)
    end

    def like_post_loader
      Loaders::RecordLoader.for(Post).load(object.post_id)
    end
  end
end
