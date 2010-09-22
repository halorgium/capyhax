require 'capybara/dsl'
Capybara.default_driver = :selenium

include Capybara

visit('http://google.com/')
save_and_open_page
