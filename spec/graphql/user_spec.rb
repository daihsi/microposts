require 'rails_helper'

RSpec.describe User do
  it '全ユーザーを取得できているか' do
    users = []
    10.times { users.push(create(:user)) }
    users_count = users.length

    query_string = <<-GRAPHQL
    {     
      users {
        id
        name
        email
        uid
      }
    }
    GRAPHQL

    result = MicropostsSchema.execute(query_string, context: {}, variables: {})
    expect(result["data"]["users"].size).to eq users_count
  end

  it '指定したユーザーを取得できているか' do
    user = create(:user)

    query_string = <<-GRAPHQL
      query UserResolver($id: Int = #{user.id.to_i}) {
        user(id: $id) {
          id
          name
          email
          uid
        }
      }
    GRAPHQL
    result = MicropostsSchema.execute(query_string, context: {}, variables: {})
    expect(result["data"]["user"]["email"]).to eq user.email
  end

  it '新規ユーザーを作成できているか' do
    input = {
      name: Faker::Name.name,
      email: Faker::Internet::email,
      password: SecureRandom.alphanumeric(4)
    }

    query_string = <<-GRAPHQL
      mutation CreateUser($name: String = "#{input[:name]}", $email: String = "#{input[:email]}", $password: String = "#{input[:password]}") {
        createUser(input: { name: $name, email: $email, password: $password }) {
          user {
            id
            name
            email
            uid
          }
        }
      }
    GRAPHQL
    result = MicropostsSchema.execute(query_string, context: {}, variables: {})
    expect(result["data"]["createUser"]["user"].blank?).to eq false
  end
end
