# frozen_string_literal: true

module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :content, String
    field :user_id, Integer, null: false
    field :post_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user_loader, Types::UserType
    field :post_loader, Types::PostType

    def user_loader
      Loaders::RecordLoader.for(User).load(object.user_id)
    end

    def post_loader
      Loaders::RecordLoader.for(Post).load(object.post_id)
    end
  end
end
