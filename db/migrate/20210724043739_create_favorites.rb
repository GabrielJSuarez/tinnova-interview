class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :beer, foreign_key: true
      t.boolean :favorite, :default => true

      t.timestamps
    end
  end
end
