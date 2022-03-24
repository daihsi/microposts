module Mutations
  class UpdatePost < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    #
    field :post, Types::PostType, null: true
    argument :id, Int, required: true
    argument :content, String, required: true

    def resolve(**args)
      post = Post.new.update_post(**args)
      {
        post: post
      }
    end
  end
end
