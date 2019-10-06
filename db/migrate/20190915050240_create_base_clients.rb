class CreateBaseClients < ActiveRecord::Migration[6.0]
  def change
    create_table :base_clients do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :client_id
      t.string :redirect_uri
      t.string :encrypted_client_secret
      t.string :encrypted_code
      t.string :encrypted_access_token
      t.string :encrypted_refresh_token
      t.string :permitted_scope
      t.integer :client_status

      t.timestamps
    end
  end
end
