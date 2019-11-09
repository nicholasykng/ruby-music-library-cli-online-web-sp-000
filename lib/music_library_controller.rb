class MusicLibraryController
  attr_accessor :path
  def initialize(path = "./db/mp3s")
    @path = path
    new_importer_object = MusicImporter.new(path)
    new_importer_object.import
  end
  def call
    input = ""
    while input != 'exit'
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip
  end
end
def list_songs
    Song.all.sort{|a,b| a.name <=> b.name}.uniq.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  def list_artists
    Artist.all.sort {|a, b| a.name <=> b.name}.uniq.each.with_index(1) do |artist, index|
      puts "#{index}. #{artist.name}"
    end
  end
  def list_genres
    Genre.all.sort{|a, b| a.name <=> b.name}.uniq.each.with_index(1) do |genre, index|
      puts "#{index}. #{genre.name}"
    end
  end
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    artist = Artist.find_by_name(input)
    if artist == nil
    else
      Artist.find_by_name(input).songs.sort{|a, b| a.name <=> b.name}.each.with_index(1) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    genre = Genre.find_by_name(input)
    if genre == nil
    else
      Genre.find_by_name(input).songs.sort{|a, b| a.name <=> b.name}.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    songs = Song.all.sort{|a, b| a.name <=> b.name}.uniq
    if (1..songs.length).include?(input)
      song = songs[input - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
  end
end
end
