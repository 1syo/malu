require 'coveralls'
Coveralls.wear!

require 'minitest/spec'
require 'minitest/autorun'

ENV['RACK_ENV'] ||= 'test'
require File.expand_path('../../app.rb', __FILE__)

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
end
