class CreateHorses < ActiveRecord::Migration[6.1]
  def change
    create_table :horses do |t|
      t.string :name
      t.text :url
      t.timestamps
    end
    add_index :horses, :name, unique: true
  end
end
