# frozen_string_literal: true

module Mutations
  class LikeCreate < BaseMutation
    description "Creates a new like"

    field :like, Types::LikeType, null: false
    argument :user_id, Int, required: true
    argument :post_id, Int, required: true

    def resolve(**args)
      like = ::Like.new(**args)
      like.save
      {
        like: like
      }
    end
  end
end
