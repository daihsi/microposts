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

    def user_loader
      Loaders::RecordLoader.for(User).load(object.user_id)
    end
  end
end
