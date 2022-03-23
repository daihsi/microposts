module Resolvers
  class PostsResolver < GraphQL::Schema::Resolver
    type [Types::PostType], null: false

    def resolve
      Post.order_id_desc
    end
  end
end