class CreateBaseItems < ActiveRecord::Migration[6.0]
  def change
    create_table :base_items do |t|
      t.references :base_user, index: true, foreign_key: true, null: false
      t.integer :item_id
      t.string :title
      t.string :detail
      t.integer :price
      t.integer :proper_price
      t.integer :item_tax_type
      t.integer :stock
      t.integer :visible
      t.integer :list_order
      t.string :identifier
      t.integer :modified
      t.string :img1_origin

      t.timestamps
    end
  end
end
