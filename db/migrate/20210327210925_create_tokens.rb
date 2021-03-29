class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :key
      t.datetime :expiration
      t.text :scopes
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tokens, :key
  end
end
