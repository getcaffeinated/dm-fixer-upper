class String
   def de_camelcase
     self.gsub(/::/, '/').
       gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
       gsub(/([a-z\d])([A-Z])/,'\1_\2').
       tr("-", "_").
       downcase
   end
  
  def camelcase
    self.capitalize
    words = self.split("_")
    words.each{|w| w.capitalize!}.join ""
  end
end

# Inspects Model.properties to create generic fixtures

module DataMapper
  module FixerUpper
    class Base
      
      attr_accessor :app_root, :models_dir, :fixtures_file, :song_titles_file, :song_lyrics_file
      
      def initialize(app_root, skip=[])
        @app_root = app_root
        @models_dir = "#{self.app_root}/models"
        @fixtures_file = "#{self.app_root}/spec/fixtures.rb"
        @models = Array.new
        self.fetch_models(skip)
        puts "Found these models: #{@models.inspect}"
      end
      
      def fetch_models(skip_arr=[])

        DataMapper::Model.descendants.each do |klass|
          @models.push << klass.to_s
        end
        
      end
      
      def fixup

        f = File.open(@fixtures_file, 'w')
        f.write(%{# Crazy moon code? Read these!
# http://github.com/datamapper/dm-more/tree/master/dm-sweatshop/
# http://github.com/benburkert/randexp/
require 'dm-sweatshop'
    }) 

        @models.each do |m|
          f.write("\n#{m}.fix {{")
          
          DataMapper::FixerUpper::Properties.get_associations(m).each do |association|
            f.write("\n\t:#{association.downcase} => #{association}.all[rand(#{association}.all.count)],")
          end
          
          DataMapper::FixerUpper::Properties.get_properties(m).each do |line|
            f.write(line)
          end
          
          f.write("\n}}\n")
        end

        f.close

      end

  #File.new("filenames.txt").readlines


    end
  end
end
