FactoryBot.define do
    factory :token do
      user { FactoryBot.create :user }
      key {'admin-api-key'}
      scopes { ['users:write'] }
    end
  end
    