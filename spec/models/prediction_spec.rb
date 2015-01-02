require 'rails_helper'

RSpec.describe Prediction, :type => :model do

  it "allows a user to enter a valid predicition" do
    prediction = Prediction.new

    prediction.set_one_opener = "Farmhouse"
    prediction.set_one_closer = "Possum"
    prediction.set_two_opener = "Bathtub Gin"
    prediction.set_two_closer = "Harry Hood"
    prediction.encore = "Good Times Bad Times"
    prediction.random_song_one = "Roggae"
    prediction.random_song_two = "1999"
    prediction.random_song_three = "Run Like an Antelope"
    prediction.random_song_four = "Sing Monica"
    prediction.random_song_five = "Farmhouse"
    prediction.animal_song = "Possum"
    prediction.gamehendge_song = "Icculus"
    prediction.cover_song = "After Midnight"
    prediction.place_song = "Farmhouse"
    prediction.elemental_song = "Light"
    prediction.name_song = "Sing Monica"


    expect(prediction.save).to eq(true)
  end

  it "does not allow a user to enter songs Phish hasn't played" do
    prediction = Prediction.new

    prediction.set_one_opener = "Party in the USA"
    prediction.set_one_closer = "Possum"
    prediction.set_two_opener = "Bathtub Gin"
    prediction.set_two_closer = "Run Like an Antelope"
    prediction.encore = "Sing Monica"
    prediction.random_song_one = "Farmhouse"
    prediction.random_song_two = "Harpua"
    prediction.random_song_three = "Mound"
    prediction.random_song_four = "Roggae"
    prediction.random_song_five = "Bathtub Gin"
    prediction.animal_song = "Possum"
    prediction.gamehendge_song = "Icculus"
    prediction.cover_song = "Time Loves a Hero"
    prediction.place_song = "Farmhouse"
    prediction.elemental_song = "Light"
    prediction.name_song = "Sing Monica"


    expect(prediction.save).to eq(false)
  end

  it "does not allow a cover song to be a phish song" do
    prediction = Prediction.new

    prediction.set_one_opener = "Farmhouse"
    prediction.set_one_closer = "Possum"
    prediction.set_two_opener = "Bathtub Gin"
    prediction.set_two_closer = "Harry Hood"
    prediction.encore = "Good Times Bad Times"
    prediction.random_song_one = "Roggae"
    prediction.random_song_two = "1999"
    prediction.random_song_three = "Run Like an Antelope"
    prediction.random_song_four = "Sing Monica"
    prediction.random_song_five = "Farmhouse"
    prediction.animal_song = "Possum"
    prediction.gamehendge_song = "Icculus"
    prediction.cover_song = "Possum"
    prediction.place_song = "Farmhouse"
    prediction.elemental_song = "Light"
    prediction.name_song = "Sing Monica"


    expect(prediction.save).to eq(false)
  end
















  #
  # pending "add some examples to (or delete) #{__FILE__}"
end
