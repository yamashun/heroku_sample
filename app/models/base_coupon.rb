class BaseCoupon < ApplicationRecord
  belongs_to :base_client

  validates :code, presence: true
end
