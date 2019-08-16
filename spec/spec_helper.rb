require 'bundler/setup'
require 'activemodel_json_validator'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
