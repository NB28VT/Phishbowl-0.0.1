class Show < ActiveRecord::Base

  Dotenv.load

  def self.load_latest_show
    latest_setlist = HTTParty.get("https://api.phish.net/api.json?api=2.0&method=pnet.shows.setlists.latest")

    jsoned = JSON.parse(latest_setlist)
    latest_setlist_data = jsoned[0]["setlistdata"]
    setlist = Nokogiri::HTML(latest_setlist_data)

    full_setlist = []


    first_set_data = setlist.css('p')[0]

    first_set_data.css('a').each do |song|
      full_setlist << song.children.text
    end

    set_two = []

    second_set_data = setlist.css('p')[1]

    second_set_data.css('a').each do |song|
      full_setlist << song.children.text
    end

    encore = []

    encore_data = setlist.css('p')[2]

    encore_data.css('a').each do |song|
      full_setlist << song.children.text
    end

    full_setlist

    # BREAK INTO SEPERATE CLASS METHODS

    # set_one = []
    #
    # first_set_data = setlist.css('p')[0]
    #
    # first_set_data.css('a').each do |song|
    #   set_one << song.children.text
    # end
    #
    # set_two = []
    #
    # second_set_data = setlist.css('p')[1]
    #
    # second_set_data.css('a').each do |song|
    #   set_two << song.children.text
    # end
    #
    # encore = []
    #
    # encore_data = setlist.css('p')[2]
    #
    # encore_data.css('a').each do |song|
    #   encore << song.children.text
    # end

  end





end
