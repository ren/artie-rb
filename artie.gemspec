# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'artie/version'

Gem::Specification.new do |spec|
  spec.name          = "artie"
  spec.version       = Artie::VERSION
  spec.authors       = ["Ren Provey"]
  spec.email         = ["ren@renprovey.com"]
  spec.summary       = %q{Artie, the helpful asset moving robot.}
  spec.description   = %q{Sketch export management via json and your trusty terminal.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"  
end
