module Types
  class UserType < Types::BaseObject
    field :id, Int, null: false
    field :uid, String, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :posts_loader, [Types::PostType]
    field :comments_loader, [Types::CommentType]
    field :follower_loader, [Types::RelationshipType]
    field :followed_loader, [Types::RelationshipType]

    def posts_loader
      Loaders::AssociationLoader.for(User, :posts).load(object)
    end

    def comments_loader
      Loaders::AssociationLoader.for(User, :comments).load(object)
    end

    def follower_loader
      Loaders::AssociationLoader.for(User, :followed).load(object)
    end

    def followed_loader
      Loaders::AssociationLoader.for(User, :follower).load(object)
    end
  end
end