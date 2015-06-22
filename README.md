Leveraging the awesome power of dm-sweatshopdm-fixer_upper magically generates a fixtures file by introspectin' all up in your models. It aims to create intelligent defaults for common types of data (names, emails, addresses, cities, states, zips, titles, descriptions, etc), so you don't have to go through much trouble to instantly populate your db with tons of reasonable test data. As of version 1.0.6, it even prepopulates belongs_to associations. Here are some sample thor tasks to get you going:

desc "create_fixtures ENV", "DESTRUCTIVE creates generic fixture file for dummy users"
def create_fixtures(env = ENV['RACK_ENV'])
  sails_init(env)
  f = DataMapper::FixerUpper::Base.new(".")
  f.fixup
end

desc "load_fixtures ENV", "loads dummy data"
def load_fixtures(env = ENV['RACK_ENV'])
  sails_init(env)
  require 'app/tests/fixtures'
  load_data
  50.times {User.gen}
  100.times {Question.gen}
end