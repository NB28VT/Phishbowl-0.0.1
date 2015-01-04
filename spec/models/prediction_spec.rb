require 'rails_helper'

RSpec.describe Prediction, :type => :model do

  it "allows a user to enter a valid predicition" do
    prediction = FactoryGirl.build(:prediction)

    expect(prediction.save).to eq(true)
  end

  it "does not allow a user to enter songs Phish hasn't played" do
    invalid_song_prediction = FactoryGirl.build(:prediction, set_one_opener: "Party in the USA")

    expect(invalid_song_prediction.save).to eq(false)
  end

  it "does not allow a cover song to be a phish song" do
    invalid_cover_prediction = FactoryGirl.build(:prediction, cover_song: "Possum")

    expect(invalid_cover_prediction.save).to eq(false)
  end

  it "does not validate a non-animal song" do
    invalid_animal_prediction = FactoryGirl.build(:prediction, animal_song: "Light")

    expect(invalid_animal_prediction.save).to eq(false)
  end

  it "does not validate a non-Gamehendge song" do
    invalid_gamehendge_prediction = FactoryGirl.build(:prediction, gamehendge_song: "Farmhouse")

    expect(invalid_gamehendge_prediction.save).to eq(false)
  end


  it "does not validate a non-Elemental song" do
    invalid_elemental_prediction = FactoryGirl.build(:prediction, elemental_song: "Farmhouse")

    expect(invalid_elemental_prediction.save).to eq(false)
  end

  it "does not validate a non-name song" do
    invalid_name_prediction = FactoryGirl.build(:prediction, name_song: "Farmhouse")

    expect(invalid_name_prediction.save).to eq(false)
  end
end
