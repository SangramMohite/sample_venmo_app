class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.integer :friend_id
      t.integer :amount
      t.string :message

      t.timestamps
    end

    add_index :payments, [:user_id, :created_at]
    add_index :payments, [:friend_id, :created_at]
  end
end
