FactoryBot.define do
  factory :registered_user do
    user
    user_type { RegisteredUser.user_types[:shop] }
    register_status { RegisteredUser.register_statuses[:registered] }
    nickname { "nickname#{id}" }
    mail_address { "example#{id}@example.com" }
    password_digest { 'password' }
    phone_number { "09011112222" }
  end
end
