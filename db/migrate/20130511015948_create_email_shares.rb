class CreateEmailShares < ActiveRecord::Migration
  def change
    create_table :email_shares do |t|
      t.string :email
      t.string :token
      t.string :status

      t.timestamps
    end
  end
end
