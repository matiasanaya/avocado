class CreateSimpleProperties < ActiveRecord::Migration
  def change
    create_table :simple_properties do |t|
      t.integer :card_id
      t.string :k
      t.string :v

      t.timestamps
    end
  end
end
