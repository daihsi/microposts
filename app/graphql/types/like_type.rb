# frozen_string_literal: true

module Types
  class LikeType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :post, Types::PostType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def like_user_loader
      Loaders::RecordLoader.for(User).load(object)
    end

    def like_post_loader
      Loaders::RecordLoader.for(Post).load(object)
    end
  end
end
