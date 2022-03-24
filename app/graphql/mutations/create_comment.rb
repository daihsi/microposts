module Mutations
  class CreateComment < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    field :comment, Types::CommentType, null: false
    argument :user_id, Int, required: true
    argument :post_id, Int, required: true
    argument :content, String, required: true

    def resolve(**args)
      comment = Comment.new.create_comment(**args)
      {
        comment: comment
      }
    end
  end
end
