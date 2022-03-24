module Mutations
  class DeletePost < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    field :post, Types::PostType, null:false
    argument :id, Int, required: true

    def resolve(id:)
      post = Post.new.delete_post(id: id)
      {
        post: post
      }
    end
  end
end
