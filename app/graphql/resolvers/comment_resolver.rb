module Resolvers
  class CommentResolver < GraphQL::Schema::Resolver
    type Types::CommentType, null: false
    argument :id, Int, required: true

    def resolve(id:)
      Comment.find(id)
    end
  end
end