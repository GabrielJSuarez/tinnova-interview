class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :name
      t.text :description
      t.string :tagline
      t.integer :abv
      t.boolean :favorite, :default => false
      t.references :user, foreign_key: true

      t.datetime :seen_at
    end
  end
end
