class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :venue, null: false
      t.datetime :show_time, null: false
      t.datetime :update_time, null: false
      t.text :setlist, array: true, default: []

      t.timestamps null: false
    end
  end
end
