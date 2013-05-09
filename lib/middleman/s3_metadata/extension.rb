require 'middleman-core'

module Middleman
  module S3Metadata

    class Options < Struct.new(:prefix,
                               :public_path,
                               :bucket,
                               :region,
                               :aws_access_key_id,
                               :aws_secret_access_key,
                               :after_build)

      # Returns an array
      def mappings
        @mappings ||= []
      end

      # object - String key for S3 object.
      # key    - Attribute key for metadata.
      # value  - Value for metadata.
      #
      # No return value
      def s3_metadata(object, key, value)
        mappings << Metadata.new(object, key, value)
      end

      protected

      class Metadata
        attr_reader :object, :key, :value

        def initialize(object, key, value)
          @object = object
          @key = key
          @value = value
        end
      end
    end

    class << self
      def options
        @@options
      end

      def registered(app, options_hash = {}, &block)
        options = Options.new(options.hash)
        yield options if block_given?

        @@options = options

        app.send :include, Helpers

        options.public_path ||= 'build'

        app.after_configuration do |config|
          after_build do |builder|
            ::Middleman::S3Metadata.generate if options.after_build
          end
        end
      end
      alias :included :registered

      def generate
        options.mappings.each do |mapping|
          if mapping.value.nil?
            puts "Unset metadata for '/#{mapping.object}' with '#{mapping.key}'"
          else
            puts "Set metadata for '/#{mapping.object}' with '#{mapping.key}' => '#{mapping.value}'"
          end
          file = s3_files.find { |i| i.key == mapping.object }
          file.reload
          file.metadata = { mapping.key => mapping.value }
          file.save
        end
      end

      def connection
        @connection ||= Fog::Storage.new(provider: 'AWS',
                                         aws_access_key_id: options.aws_access_key_id,
                                         aws_secret_access_key: options.aws_secret_access_key,
                                         region: options.region)
      end

      def bucket
        @bucket ||= connection.directories.get(options.bucket)
      end

      def s3_files
        @s3_files ||= bucket.files
      end

      module Helpers
        def s3_metadata(object, key, value)
          ::Middleman::S3Metadata.options.s3_metadata(object, key, value)
        end

        def s3_metadata_options
          ::Middleman::S3Metadata.options
        end
      end
    end

  end
end
