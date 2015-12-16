# Middleman::S3Metadata

[![Code Climate](https://codeclimate.com/github/qnyp/middleman-s3_metadata/badges/gpa.svg)](https://codeclimate.com/github/qnyp/middleman-s3_metadata)

This gem automates updating metadata of specific AWS S3 object.

Use case:

* Set suitable `Content-Type` for RSS file
* Remove 'Cache-Control' and 'Expires' header to disable strong caching

## Compatibility

* middleman-s3_metadata 0.2.x is for Middleman 4.x
* middleman-s3_metadata 0.1.x is for Middleman 3.x

## Installation

Add this line to your application's Gemfile:

    gem 'middleman-s3_metadata'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-s3_metadata

## Usage

You need to add the following code to your config.rb file:

```ruby
activate :s3_metadata do |config|
  config.bucket                = 'my.bucket.com' # The name of the S3 bucket you are targetting. This is globally unique.
  config.region                = 'us-west-1'     # The AWS region for your bucket.
  config.aws_access_key_id     = 'AWS KEY ID'
  config.aws_secret_access_key = 'AWS SECRET KEY'
  config.after_build           = false # We chain after the build step by default. This may not be your desired behavior...
end
```

The `s3_metadata` method set a metadata for S3 object:

```ruby
# Set suitable Content-Type
s3_metadata('feeds/feed.rss', 'Content-Type', 'rss/xml')
s3_metadata('archives.tar.gz', 'Content-Type', 'application/x-gzip')

# Disable caching
s3_metadata('index.html', 'Cache-Control', nil)
s3_metadata('index.html', 'Expires', nil)
```

First argument is key for S3 object, second and third arguments is key and value for metadata.

## A Debt of Gratitude

I used middleman-sync and middleman-s3_redirect as a template for building a Middleman extension.
My gratitude goes to @karlfreeman and @fredjean.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
