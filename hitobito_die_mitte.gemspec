# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your wagon's version:
require "hitobito_die_mitte/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "hitobito_die_mitte"
  s.version = HitobitoDieMitte::VERSION
  s.authors = ["Andreas Maierhofer"]
  s.email = ["maierhofer@puzzle.ch"]
  s.summary = "Die Mitte organization specific features"
  s.description = "Die Mitte organization specific features"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"]

  s.add_dependency "globalize-accessors"
end
