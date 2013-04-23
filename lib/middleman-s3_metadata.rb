require 'middleman-core'
require 'fog'
require 'middleman/s3_metadata/version'
require 'middleman/s3_metadata/commands'

::Middleman::Extensions.register(:s3_metadata, '>= 3.0.0') do
  require 'middleman/s3_metadata/extension'
  ::Middleman::S3Metadata
end
