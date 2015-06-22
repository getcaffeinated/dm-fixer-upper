require 'rubygems'
require 'open-uri'
require 'nokogiri'


module DataMapper
  module FixerUpper
		class Lyrics < Base

      attr_accessor :song_titles_file, :song_lyrics_file, :options
      
      def initialize(app_root, options={})
        super(app_root)
        @options = options
        @song_titles_file = "#{self.app_root}/../tmp/song_titles.txt"
        @song_lyrics_file = "#{self.app_root}/../tmp/song_lyrics.txt"
      end
      
      def sing!
        self.write_song_titles
        self.write_song_lyrics
      end
      
      def write_song_lyrics
        self.get_song_lyrics
        self.write_file(@song_lyrics_file, @song_lyrics.join(""))
      end
        
      def write_song_titles
        self.get_song_titles
        self.write_file(@song_titles_file, @song_titles.join("\n"))
      end
      
      def write_file(file, data)
        f = File.open(file, 'w')
        f.write(data)
        f.close
      end
      
      def get_song_lyrics
        @song_lyrics = Array.new
        @song_titles.each do |song|
          puts "Processing #{song}..."
          song.gsub!(/\s/, '%20')
          query = "getSong&artist=#{@options[:artist]}&song=#{song}"
          doc = self.get_xml(query)
          
          doc.xpath("//lyrics").each do |item|
            lyrics = item.text
            lyrics.gsub!(/\n/, '. ')
            @song_lyrics << lyrics
          end
        end
        
      end
      
      def get_xml(query)
        url="http://lyrics.wikia.com/api.php?fmt=xml&func=#{query}"
        Nokogiri::XML(open(url))
      end
      
      def get_song_titles
        @song_titles = Array.new
  
        @options[:artist] = 'Michael%20Jackson' if not @options[:artist]
        query = "getArtist&artist=#{@options[:artist]}"
        doc = self.get_xml(query)

        doc.xpath("//item").each do |item|
          @song_titles << item.text
        end
        
        @song_titles.uniq!

      end

      def self.song_title
        @song_titles.rand(size)
      end

    end
  end
end