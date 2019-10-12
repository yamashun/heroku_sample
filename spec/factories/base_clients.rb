FactoryBot.define do
  factory :base_client do
    user
    client_id { 'xxxx' }
    client_secret { 'yyyy' }
    code { 'zzzz' }
  end
end
