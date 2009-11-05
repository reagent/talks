require "rubygems"
require "selenium"
require "test/unit"
require "open-uri"

class NewTest < Test::Unit::TestCase
  def setup
    base_url = "http://spasibo.com/"
    open("#{base_url}setup/clean_slate")
    
    @verification_errors = []
    if $selenium
      @selenium = $selenium
    else
      @selenium = Selenium::SeleniumDriver.new("localhost", 4444, "*chrome", base_url, 10000);
      @selenium.start
    end
    @selenium.set_context("test_new")
  end
  
  def teardown
    @selenium.stop unless $selenium
    assert_equal [], @verification_errors
  end
  
  def test_new
    @selenium.open "/"
    @selenium.click "link=Register"
    @selenium.wait_for_page_to_load "30000"
    @selenium.type "user_email", "user@host.com"
    @selenium.type "user_password", "password"
    @selenium.type "user_password_confirmation", "password"
    @selenium.click "user_terms"
    @selenium.click "user_submit"
    @selenium.wait_for_page_to_load "30000"
    @selenium.wait_for_page_to_load "5000"
    begin
        assert @selenium.is_text_present("Welcome to Spasibo. A winner is you!")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
    begin
        assert_equal "http://spasibo.com/", @selenium.get_location
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
  end
end
