module Resolvers
  class PostsSortResolver < GraphQL::Schema::Resolver
    type [Types::PostType], null: false
    argument :sort, String, required: true

    def resolve(sort:)
      post = Post.new
      post.posts_sort(sort: sort)
    end
  end
end