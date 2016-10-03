require 'awesome_print'
require 'fileutils'
require './lib/image_helper.rb'

RSpec.configure do |config|
  config.filter_run(focus: true)
  config.fail_fast = true
  config.run_all_when_everything_filtered = true
end

def fixture(path)
  File.expand_path("./spec/fixtures/#{path}")
end
