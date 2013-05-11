class CreateEmailShares < ActiveRecord::Migration
  def change
    create_table :email_shares do |t|
      t.integer :card_id
      t.string :email
      t.string :token
      t.string :status

      t.timestamps
    end
  end
end
