module Mutations
  class CreateUser < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    field :user, Types::UserType, null: true
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    def resolve(**args)
      user = User.create(name: args[:name], email: args[:email], password: args[:password])
      {
        user: user
      }
    end
  end
end
