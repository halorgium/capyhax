require 'rubygems'
require 'bundler/setup'

require 'capybara'
require 'capybara/dsl'
Capybara.default_driver = :selenium

include Capybara

ENV["DISPLAY"] = ":20"

# Check if Xvfb is running (for headless Firefox) and run it again
if %x[ps -ef | grep "xinit" | grep -v grep].empty?
  auth_file = "#{ENV['HOME']}/X99.cfg"
  system "echo 'localhost' > #{auth_file}"
  system "xinit -- `which Xvfb` #{ENV['DISPLAY']} -screen 0 1024x768x24 -auth #{auth_file} 2>&1 > xinit.log &"
end

visit "http://google.com/"
fill_in "q", :with => "you are the fail"
click_button "Google Search"

sleep 10

windows = `lsw`.split("\n")

window = windows.find do |w|
  w =~ /Google/
end

system "import -window '#{window}' screen.png"
