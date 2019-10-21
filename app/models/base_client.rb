class BaseClient < ApplicationRecord
  has_many :base_coupons
  belongs_to :user

  attr_encrypted :client_secret, :code, :access_token, :refresh_token, key: Settings.base_client_key
  validates :client_id, presence: true
end
