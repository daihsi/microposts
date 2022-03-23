module Mutations
  class UpdateUser < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    field :user, Types::UserType, null: true
    argument :id, Int, required: true
    argument :name, String, required: false
    argument :email, String, required: false
    argument :password, String, required: false

    def resolve(**args)
      user = User.find(args[:id])
      user.update(name: args[:name], email: args[:email], password: args[:password])
      {
        user: user
      }
    end
  end
end
