# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knife-dot/version'

Gem::Specification.new do |gem|
  gem.name          = "knife-dot"
  gem.version       = KnifeDot::VERSION
  gem.authors       = ["Maciej Pasternacki"]
  gem.email         = ["maciej@ginzametrics.com"]
  gem.description   = "Knife plugin to draw a dependency graph of environments, nodes, roles, and cookbooks"
  gem.summary       = "Knife plugin to draw dependency graph"
  gem.homepage      = "https://github.com/ginzamarkets/knife-dot/"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'chef'
end
