# Load the rails application
require File.expand_path('../application', __FILE__)
require "fbgraph"

# Initialize the rails application
Resignako::Application.initialize!

Rails.logger = Logger.new(STDOUT)
