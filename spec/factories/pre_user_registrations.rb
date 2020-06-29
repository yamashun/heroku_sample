FactoryBot.define do
  factory :pre_user_registration do
    user
    status { :notyet }
    mail_address { "example#{id}@example.com" }
    password_digest { 'password' }
  end
end
