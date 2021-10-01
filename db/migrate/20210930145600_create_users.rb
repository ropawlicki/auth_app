class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, unique: true, null: false
      t.string :password_hash, null: false
      t.integer :failed_signin_attempts, default: 0

      t.timestamps
    end
  end
end
