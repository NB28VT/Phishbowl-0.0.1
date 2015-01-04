require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    username 'John'
    password 'password'
    password_confirmation 'password'
  end


  factory :prediction do
    set_one_opener "Farmhouse"
    set_one_closer "Possum"
    set_two_opener "Bathtub Gin"
    set_two_closer "Harry Hood"
    encore "Good Times Bad Times"
    random_song_one "Roggae"
    random_song_two "1999"
    random_song_three "Run Like an Antelope"
    random_song_four "Sing Monica"
    random_song_five "Farmhouse"
    animal_song "Possum"
    gamehendge_song "Icculus"
    cover_song "After Midnight"
    place_song "Farmhouse"
    elemental_song "Light"
    name_song "Sing Monica"
  end



end
