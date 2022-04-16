module Types
  class RelationshipType < Types::BaseObject
    field :id, ID, null: false
    field :follower_id, Integer, null: false
    field :followed_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :follower_loader, Types::UserType
    field :followed_loader, Types::UserType

    def follower_loader
      Loaders::RecordLoader.for(User).load(object.follower_id)
    end

    def followed_loader
      Loaders::RecordLoader.for(User).load(object.followed_id)
    end
  end
end
