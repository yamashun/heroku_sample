class CreatePreUserRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :pre_user_registrations do |t|
      t.references :user, foreign_key: false, null: true
      t.datetime   :expiration_datetime
      t.string     :mail_address
      t.string     :password_digest
      t.string     :verify_token
      t.integer    :status

      t.timestamps null: false
    end
  end
end
