# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman/s3_metadata/version'

Gem::Specification.new do |spec|
  spec.name          = 'middleman-s3_metadata'
  spec.version       = Middleman::S3Metadata::VERSION
  spec.authors       = ['Junya Ogura', 'QNYP, LLC.']
  spec.email         = ['junyaogura@gmail.com']
  spec.description   = %q{Set Content-Type metadata for S3 objects after syncing.}
  spec.summary       = %q{Set Content-Type metadata for S3 objects after syncing.}
  spec.homepage      = 'https://github.com/juno/middleman-s3_metadata'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'middleman-core', '>= 3.0.0'
  spec.add_runtime_dependency 'fog'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
