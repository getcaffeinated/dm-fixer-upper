require 'rubygems'
require 'dm-core'

require File.join(File.expand_path(File.join(File.dirname(__FILE__))), '..', 'lib', 'data_mapper', 'fixer_upper')
require File.join(File.expand_path(File.join(File.dirname(__FILE__))), '..', 'lib', 'data_mapper', 'fixer_upper', 'properties')
require File.join(File.expand_path(File.join(File.dirname(__FILE__))), '..', 'lib', 'data_mapper', 'fixer_upper', 'lyrics')

require 'test/unit'

TEST_DIR = "/work/sc/poeks"
Dir.glob(File.join(TEST_DIR, 'models', '**/*.rb')).each { |f| require f }

class FixerUpperTest < Test::Unit::TestCase
  
  def test_main_methods
    
    
    f = DataMapper::FixerUpper::Base.new(TEST_DIR)
    f.fixup
    
    assert true
  end
  
  def test_ext
    #puts Randgen.song_title
    
    assert true
  end
  
  def test_song_titles
    #f = DataMapper::FixerUpper::Lyrics.new(TEST_DIR, {:artist => 'Britney_Spears'})
    #f.sing!
    assert true
  end
  
  def test_skip
    f = DataMapper::FixerUpper::Base.new(TEST_DIR, ["thing.rb"])
    f.fixup
  end
  
end