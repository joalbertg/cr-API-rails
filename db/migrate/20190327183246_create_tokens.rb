class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.references :user, index: true
      t.string :token
      t.datetime :expires_at

      t.timestamps null: false
    end
    add_foreign_key :tokens, :users
  end
end
