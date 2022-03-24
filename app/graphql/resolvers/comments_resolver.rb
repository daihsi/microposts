module Resolvers
  class CommentsResolver < GraphQL::Schema::Resolver
    type [Types::CommentType], null: false

    def resolve
      Comment.id_desc
    end
  end
end