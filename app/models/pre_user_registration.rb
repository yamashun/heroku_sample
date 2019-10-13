class PreUserRegistration < ApplicationRecord
  has_secure_password validations: false
  before_create :prepare_create

  belongs_to :user, optional: true

  validates :mail_address, presence: true,
            format: { with: %r(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z) }
  # validates :password, presence: true,
  #           length: { minimum: 4, maximum: 100 }

  enum status: {
    notyet:     0,
    registered: 1,
  }

  private

  def prepare_create
    self.expiration_datetime = 30.days.since
    self.verify_token = SecureRandom.hex(20)
  end
end
