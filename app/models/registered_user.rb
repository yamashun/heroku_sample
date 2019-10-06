class RegisteredUser < ApplicationRecord
  has_secure_password validations: false

  belongs_to :user

  enum register_status: {
    notyet:     0,
    registered: 1,
  }

  enum user_type: {
    admin:    0,
    shop:      1,
    normal:    2,
  }
end
