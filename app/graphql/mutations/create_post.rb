module Mutations
  class CreatePost < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    field :post, Types::PostType, null: true
    argument :user_id, Int, required: true
    argument :content, String, required: true

    def resolve(**args)
      post = Post.new.create_post(**args)
      {
        post: post
      }
    end
  end
end
