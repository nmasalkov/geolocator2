class CreateLocations < ActiveRecord::Migration[7.0]
  create_table :locations do |t|
    t.text :url
    t.text :ip_address, null: false
    # may be specific types in advanced rdbms
    t.float :latitude, null: false
    t.float :longitude, null: false

    t.timestamps
  end

  add_index :locations, :url, unique: true
  add_index :locations, :ip_address, unique: true
end
