class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address
      t.datetime :last_claim_at

      t.timestamps
    end
  end
end
