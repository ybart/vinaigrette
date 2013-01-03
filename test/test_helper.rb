require 'simplecov'

SimpleCov.start do
  add_filter 'vendor'
  add_filter 'test'
end

require 'minitest/autorun'
require 'minitest/pride'
require "minitest/hell"

require File.expand_path('../../lib/vinaigrette.rb', __FILE__)

require 'mocha/setup'
