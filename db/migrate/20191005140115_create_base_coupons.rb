class CreateBaseCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :base_coupons do |t|
      t.references :base_client, foreign_key: false, null: true
      t.string     :code, null: false
      t.string     :name
      t.integer    :discount_price
      t.integer    :discount_ratio
      t.integer    :number
      t.integer    :minimum_price
      t.datetime   :available_from
      t.datetime   :available_to
      t.integer    :used_number
      t.integer    :status

      t.timestamps null: false
    end
  end
end
