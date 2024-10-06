class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.string :rules_url
      t.string :shop_url

      t.timestamps
    end

    add_index :games, :name, unique: true
  end
end
