$:.push File.expand_path("../lib", __FILE__)

require "model_integrity_check/version"

Gem::Specification.new do |s|
  s.name        = "model_integrity_check"
  s.version     = ModelIntegrityCheck::VERSION
  s.authors     = ["Jeff Pickhardt"]
  s.email       = ["pickhardt@gmail.com"]
  s.homepage    = "http://supso.org/projects/model-integrity-check"
  s.summary     = "Gives reports on invalid models."
  s.description = "Check your Rails models to see how many are invalid."
  s.license     = "TBD"

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
end
