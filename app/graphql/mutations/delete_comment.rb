module Mutations
  class DeleteComment < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    field :comment, Types::CommentType, null: false
    argument :id, Int, required: true

    def resolve(id:)
      comment = Comment.new.delete_comment(id: id)
      {
        comment: comment
      }
    end
  end
end
