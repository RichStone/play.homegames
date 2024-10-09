class CreateStatsCompetitions < ActiveRecord::Migration[8.0]
  def change
    create_table :stats_competitions do |t|
      t.references :game, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
