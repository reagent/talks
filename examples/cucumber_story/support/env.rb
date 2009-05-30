require 'selenium/client'
require 'test/unit/assertions'
require 'open-uri'

# Use Test::Unit assertions (n-Unit style)
World(Test::Unit::Assertions)

BASE_URL = 'http://spasibo.com'

# TODO: what do these options mean?
browser = Selenium::Client::Driver.new(
  :host    => 'localhost',
  :port    => 4444,
  :browser => '*firefox',
  :url     => BASE_URL
)

browser.start_new_browser_session

Before do
  @browser  = browser
end

# "after all"
at_exit do
  browser.close_current_browser_session
end