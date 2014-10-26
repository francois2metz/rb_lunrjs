# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rb_lunrjs'

Gem::Specification.new do |spec|
  spec.name          = "rb_lunrjs"
  spec.version       = RbLunrjs::VERSION
  spec.authors       = ["Christian Hellsten"]
  spec.email         = ["christian.hellsten@aktagon.com"]
  spec.summary       = %q{Writase a lunr.js index to JSON with Ruby.}
  spec.description   = %q{Writes a lunr.js index to JSON with Ruby.}
  spec.homepage      = "http://github.com/christianhellsten/rb_lunrjs"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  %w(coffee-script therubyracer).each do |name|
    spec.add_dependency name
  end
end
