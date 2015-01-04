class Prediction < ActiveRecord::Base

  Dotenv.load
  # api_key = ENV[names of keys]


  def load_latest_show
    latest_setlist = HTTParty.get("https://api.phish.net/api.json?api=2.0&method=pnet.shows.setlists.latest")

    jsoned = JSON.parse(latest_setlist)
    latest_setlist_data = jsoned[0]["setlistdata"]
    setlist = Nokogiri::HTML(latest_setlist_data)

    set_one = []

    first_set_data = setlist.css('p')[0]

    first_set_data.css('a').each do |song|
      set_one << song.children.text
    end

    set_two = []

    second_set_data = setlist.css('p')[1]

    second_set_data.css('a').each do |song|
      set_two << song.children.text
    end

    encore = []

    encore_data = setlist.css('p')[2]

    encore_data.css('a').each do |song|
      encore << song.children.text
    end
  end

  # old code for csv file. Delete some day.
  # def load_song_list
  #   # IN THE FUTURE, LOAD TO DB FOR ACCESS
  #   contents = File.read("song_list_raw.txt")
  #   lines = File.readlines("song_list_raw.txt")
  #
  #   songs = []
  #
  #   lines.each do |line|
  #     song = line.split("\")[1]
  #     songs << song
  #   end
  #   songs = songs.compact
  # end



  # Loads a list of all Phish songs and covers from Phish.net, into hash
  def self.load_songs_and_gaps

    load_song_page = HTTParty.get("http://phish.net/song/")
    parsed_song_page = Nokogiri::HTML(load_song_page)
    song_rows = parsed_song_page.css('tr')

    songs_hash = {}

    song_rows.each do |song|
      song_info = {}
      title = song.children.children[0].text
      artist = song.children.children[1].text
      if song.children.children[5]
        gap = song.children.children[5].text
      else
        gap = nil
      end

      song_info["artist"] = artist
      song_info["gap"] = gap

      songs_hash[title] = song_info
    end

    # removes first row (column header)

    songs_hash.delete("Song Name")
    songs_hash
  end

  def self.load_cover_songs(song_hash)
    cover_songs = []
    song_hash.each do |song|
      if song[1]["artist"] != "Phish"
        cover_songs << song[0]
      end
    end
    cover_songs
  end

  #Returns a hash of songs with artist and gap as values
  @songs_hash = load_songs_and_gaps

  @cover_songs = load_cover_songs(@songs_hash)

  @valid_elemental_songs = ["Fire","Fire on the Mountain","Fire Up the Ganja", "Who By Fire", "Chariots of Fire", "Smoke on the Water", "The Chinese Water Torture", "Water in the Sky", "Cold Water", "Listening Wind", "Wind Beneath My Wings", "Windy City", "Four Strong Winds", "Light", "Fuego", "Daniel Saw the Stone", "Waves", "Born Under Punches (The Heat Goes On)", "Feel the Heat", "Burning Down the House", "Burn that Bridge", "Cold as Ice", "It\'s Ice", "Steam", "Dave\'s Energy Guide", "Dirt", "Dust in the Wind", "Energy", "Foam", "I Am Hydrogen", "N02", "Plasma", "Rocks Off", "Sea and Sand", "Sparks", "Steam", "Thunder Road", "Wading in the Velvet Sea", "A Song I Heard the Ocean Sing" ]

  @valid_animal_songs = ["Baby Elephant Walk", "Back at the Chicken Shack", "Big Alligator", "Big Black Furry Creature from Mars", "Birds of a Feather", "Bug", "Camel Walk", "Dixie Chicken", "Dog Faced Boy", "Dog Log", "Dogs Stole Things", "Everybody's Got Something to Hide Except Me and My Monkey", "Fee", "Fly Famous Mockingbird", "Fly Like an Eagle", "Free Bird", "Harpua", "I am the Walrus", "Little Red Rooster", "Llama", "Moby Dick", "Monkey Man", "Moose the Mooche", "No Dogs Allowed", "Ocelot", "On Green Dolphin Street", "Possum", "Rhinoceros", "Roadrunner", "Rocky Racoon", "Run Like and Antelope", "Runaway Jim", "Scent of a Mule", "Shaggy Dog", "Sleeping Monkey", "Skippy the Wondermouse", "Spanish Flea", "Terrapin", "The Birds", "The Birdwatcher", "The Chicken", "The Dogs", "The Fishin' Hole", "The Horse", "The Lion Sleeps Tonight", "The Lizards", "The Sloth", "Three Little Birds", "Timber(Jerry)", "Vultures", "White Rabbit", "Wombat" ]

  @valid_gamehendge_songs = [ "The Man Who Stepped into Yesterday", "The Lizards", "Tela", "Wilson", "AC/DC Bag", "Colonel Forbin's Ascent", "Fly Famous Mockingbird", "The Sloth", "Possum", "Divided Sky", "Llama", "McGrupp and the Watchful Hosemasters", "Punch You in the Eye", "Icculus", "Harpua", "Axilla", "Axilla, Part 2", "Kung"]

  @valid_place_songs = [ "Alaska", "Albuquerque", "Babylon is Burning", "Back at the Chicken Shack", "Back in the U.S.S.R", "Bitterwsweet Motel", "Blue Bayou", "Bouncing Around the Room", "California Love", "Carolina", "Cities", "Crossroads", "Down By the River", "El Paso", "Farmhouse", "Free Man in Paris", "Halfway to the Moon", "Highway to Hell", "How High the Moon", "I Been to Georgia on a Fast Train", "In a Hole", "In the Aeroplane Over the Sea", "Jesus Just Left Chicago", "Kill Devil Falls", "L.A. Woman", "La Grange", "Life on Mars?", "Lushington", "Midnight on the Highway", "Misty Mountain Hop", "Moonlight in Vermont", "Mound", "Mountains in the Mist", "New York, New York", "Norwegian Wood (This Bird Has Flown)", "Oh Atlanta", "On Green Dolphin Street", "Rocky Mountain Way", "Somewhere Over the Rainbow", "Spanish Moon", "Stairway to Heaven", "Sugar Shack", "Susskind Hotel", "Sweet Virginia", "Tennessee Waltz", "Terrapin Station", "The Haunted House", "The Old Home Place", "Trench Town Rock", "Wading in the Velvet Sea", "Walls of the Cave", "Windy City", "Yarmouth Road" ]




  [
    :set_one_opener,
    :set_one_closer,
    :set_two_opener,
    :set_two_closer,
    :encore,
    :random_song_one,
    :random_song_two,
    :random_song_three,
    :random_song_four,
    :random_song_five,
    :animal_song,
    :gamehendge_song,
    :cover_song,
    :place_song,
    :elemental_song,
    :name_song
  ].each do |n|
    validates n, inclusion: { in: @songs_hash.keys, message: "Picks must be a song Phish has played."}
  end

  validates :cover_song, inclusion: { in: @cover_songs, message: "Cover song cannot be a Phish song." }
  validates :animal_song, inclusion: { in: @valid_animal_songs, message: "Invalid animal song!" }
  validates :gamehendge_song, inclusion: { in: @valid_gamehendge_songs, message: "Invalid Gamehendge song!" }
  validates :place_song, inclusion: { in: @valid_place_songs, message: "Invalid Gamehendge song!" }



end
