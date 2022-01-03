class CreateHorseDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :horse_details do |t|
      t.references :horse, polymorphic: true
      t.date :date, null: false
      t.text :weather, null: false
      t.text :race_name, null: false
      t.string :ranking, null: false
      t.string :popularity, null: false
      t.text :jockey, null: false
      t.text :race_condition, null: false
      t.string :race_distance, null: false
      t.float :time, null: false
      t.float :dressing_difference_time, null: false
      t.string :body_weight, null: false
      t.timestamps
    end
  end
end
