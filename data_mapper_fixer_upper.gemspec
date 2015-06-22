Gem::Specification.new do |s|
  s.name        = "dm-fixer_upper"
  s.version     = "1.3"
  s.authors     = ['Jen Oslislo']
  s.email       = ["jennifer@stepchangegroup.com"]
  s.homepage    = "https://github.com/mjfreshyfresh/dm-fixer_upper"
  s.summary     = "Generic fixtures for your models."
  s.description = "Introspects on your DataMapper models and creates a generic fixtures file to be run with dm-sweatshop and randexp."

  s.files        = Dir["{lib,test}/**/*"] + Dir["[A-Z]*"]
  s.require_path = "lib"

  s.rubyforge_project = s.name
end

