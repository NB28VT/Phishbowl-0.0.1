class AddPredictionTable < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.string :set_one_opener, null: false
      t.string :set_one_closer, null: false
      t.string :set_two_opener, null: false
      t.string :set_two_closer, null: false
      t.string :encore, null: false
      t.string :random_song_one, null: false
      t.string :random_song_two, null: false
      t.string :random_song_three, null: false
      t.string :random_song_four, null: false
      t.string :random_song_five, null: false
      t.string :animal_song, null: false
      t.string :gamehendge_song, null: false
      t.string :cover_song, null: false
      t.string :place_song, null: false
      t.string :elemental_song, null: false
      t.string :name_song, null: false
    end
  end
end
