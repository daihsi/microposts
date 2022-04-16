module Mutations
  class Following < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    field :follow, Types::RelationshipType, null: false
    argument :follower_id, Int, required: true
    argument :followed_id, Int, required: true

    def resolve(**args)
      user = User.find(args[:follower_id])
      follow = user.follow(user_id: args[:followed_id])
      {
        follow: follow
      }
    end
  end
end
