module Types
  class UserType < Types::BaseObject
    field :id, Int, null: false
    field :uid, String, null: false
    field :name, String, null: false
    field :email, String, null: false
  end
end