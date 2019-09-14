class CreateRegisteredUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :registered_users do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :user_type
      t.integer :register_status
      t.string :nickname
      t.string :mail_address
      t.string :phone_number
      t.string :password_digest

      t.timestamps
    end
  end
end
