class CreateBaseUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :base_users do |t|
      t.references :base_client, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: false, null: true
      t.string :shop_id
      t.string :shop_name
      t.string :shop_introduction
      t.string :twitter_id
      t.string :facebook_id
      t.string :ameba_id
      t.string :instagram_id
      t.string :background_url
      t.integer :display_background
      t.integer :repeat_background
      t.string :logo
      t.integer :display_logo
      t.string :mail_address

      t.timestamps
    end
  end
end
