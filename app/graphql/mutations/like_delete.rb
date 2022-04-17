# frozen_string_literal: true

module Mutations
  class LikeDelete < BaseMutation
    description "Deletes a like by ID"

    field :unlike, Types::UserType, null: false

    argument :user_id, Integer, required: true
    argument :post_id, Integer, required: true

    def resolve(**args)
      user = User.find_by(id: args[:user_id])
      user.unlike_post(post_id: args[:post_id])
      {
        unlike: user
      }
    end
  end
end
