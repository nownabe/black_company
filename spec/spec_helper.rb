require "simplecov"
SimpleCov.start do
  add_filter "spec"
end

if ENV["CI"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'black_company'
