class Prediction < ActiveRecord::Base

  Dotenv.load
  # api_key = ENV[names of keys]

  elemental_songs = ["Fire","Fire on the Mountain","Fire Up the Ganja", "Who By Fire", "Chariots of Fire", "Smoke on the Water", "The Chinese Water Torture", "Water in the Sky", "Cold Water", "Listening Wind", "Wind Beneath My Wings", "Windy City", "Four Strong Winds", "Light", "Fuego", "Daniel Saw the Stone", "Waves", "Born Under Punches (The Heat Goes On)", "Feel the Heat", "Burning Down the House", "Burn that Bridge", "Cold as Ice", "It\'s Ice", "Steam", "Dave\'s Energy Guide", "Dirt", "Dust in the Wind", "Energy", "Foam", "I Am Hydrogen", "N02", "Plasma", "Rocks Off", "Sea and Sand", "Sparks", "Steam", "Thunder Road", "Wading in the Velvet Sea", "A Song I Heard the Ocean Sing" ]

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
  #     song = line.split("\"")[1]
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


  @songs_hash = load_songs_and_gaps

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


  # START HERE
  # validates :cover_song, if: { @songs_hash[:cover_song][:artist] != "Phish" }
























end
