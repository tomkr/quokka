require "simplecov"
SimpleCov.start

require "webmock/rspec"
WebMock.disable_net_connect!(allow_localhost: true)

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "quokka"
