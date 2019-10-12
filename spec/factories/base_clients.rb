FactoryBot.define do
  factory :base_client do
    user
    client_id { 'aaaa' }
    client_secret { 'bbbb' }
    code { 'cccc' }
    auth_state { 'dddd' }
  end
end
