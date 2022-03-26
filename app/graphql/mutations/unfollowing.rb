module Mutations
  class Unfollowing < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    field :unfollow, Types::RelationshipType, null: false
    argument :follower_id, Int, required: true
    argument :followed_id, Int, required: true

    def resolve(**args)
      user = User.find(args[:follower_id])
      user.unfollow(user_id: args[:followed_id])
      {
        user: user
      }
    end
  end
end
