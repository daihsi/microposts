# frozen_string_literal: true

module Mutations
  class LikeDelete < BaseMutation
    description "Deletes a like by ID"

    field :like, Types::LikeType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      like = ::Like.find(id)
      raise GraphQL::ExecutionError.new "Error deleting like", extensions: like.errors.to_hash unless like.destroy

      { like: like }
    end
  end
end
