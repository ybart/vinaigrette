# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sausage/version'

Gem::Specification.new do |gem|
  gem.name          = "sausage"
  gem.version       = Sausage::VERSION
  gem.authors       = ["Yvan BARTHÉLEMY"]
  gem.email         = ["ybarthelemy@direct-streams.com"]
  gem.description   = %q{Custom serializable ActiveModel object.}
  gem.summary       = %q{Provides a custom serializable ActiveModel object with ActiveModel validations and ActiveRecord associations.}
  gem.homepage      = "http://ybart.github.com/sausage"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest',  '>= 4.2.0'
  gem.add_development_dependency 'simplecov', '>= 0.3.8'
  gem.add_development_dependency 'mocha',     '>= 0.13.1'

  gem.add_dependency 'activerecord',          '>= 3.0.0'
  # gem.add_dependency 'activesupport',       '>= 3.0.0' # ActiveSupport::Concern
  # gem.add_dependency 'activemodel',         '>= 3.0.0' # ActiveModel::Validations
end
