class User < ApplicationRecord
  has_one :registered_user
  has_one :base_client

  delegate :shop?, to: :registered_user
  delegate :admin?, to: :registered_user
end
