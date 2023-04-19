class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.integer :year
      t.boolean :live, default: false
      t.references :band, null: false, foreign_key: true

      t.timestamps
    end

    add_index :albums, [:title, :band_id], unique: true
  end
end
