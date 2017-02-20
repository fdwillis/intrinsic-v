require 'clockwork'
require './config/boot'
require './config/environment'
module Clockwork
  handler do |job|
    puts "Running #{job}"
  end
  
  # every(1.month, 'invoice email', if: lambda { |t| t.day == 1 }) {
  #   `rake run:invoice`
  # }

  # every(36.hours, 'grab data') {
  #   `rake run:grab_data`
  # }
end