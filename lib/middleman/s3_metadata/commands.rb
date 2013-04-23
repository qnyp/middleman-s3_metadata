require 'middleman-core/cli'
require 'middleman/s3_metadata/extension'

module Middleman
  module Cli
    class S3Metadata < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :s3_metadata

      def self.exit_on_failure?
        true
      end

      desc 's3_metadata', 'Updates metadata for S3 objects.'
      def s3_metadata
        shared_inst = ::Middleman::Application.server.inst

        if (!shared_inst.respond_to?('s3_metadata_options') ||
            !shared_inst.s3_metadata_options.aws_access_key_id)
          raise Thor::Error.new 'You need to activate this extension.'
        end

        ::Middleman::S3Metadata.generate
      end
    end
  end
end
