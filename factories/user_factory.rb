FactoryBot.define do
  factory :user do
    username { 'testuser' }
    password { '123456' }
    failed_signin_attempts { 0 }
  end
end
