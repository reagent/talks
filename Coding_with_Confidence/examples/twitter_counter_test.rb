require 'rubygems'

require 'test/unit'
require 'net/http'
require 'json'

require 'mocha'

# Construct the URL to the API (done)
# Based on JSON data, retrieve follower_count for a user (done)
# Hit the API and retrieve JSON data (done)
# Get a follower count for a username

# See what happens when I pass in an empty username (exception?)


class TwitterCounterTest < Test::Unit::TestCase
  
  def test_should_know_the_url_based_on_the_username
    url = "http://twittercounter.com/api/?username=reagent&output=json"
    
    tc = TwitterCounter.new('reagent')
    assert_equal url, tc.url
  end

  def test_should_know_the_endpoint
    url = "http://twittercounter.com/api/?username=reagent&output=json"
    
    tc = TwitterCounter.new('reagent')
    assert_equal URI.parse(url), tc.endpoint
  end
  
  def test_should_be_able_to_fetch_a_response_from_the_api
    url = "http://twittercounter.com/api/?username=reagent&output=json"
    uri = URI.parse(url)
    
    Net::HTTP.expects(:get).with(uri).returns('json_data')
    
    tc = TwitterCounter.new('reagent')
    assert_equal 'json_data', tc.response
  end
  
  def test_should_retrieve_follower_count_for_a_user
    
    twitter_counter = stub(:response => 'json_data')
    user            = stub(:follower_count => '1')

    TwitterCounter.expects(:new).with('reagent').returns(twitter_counter)
    
    User.expects(:new).with('json_data').returns(user)
    
    count = TwitterCounter.for('reagent')
    assert_equal '1', count
    
    
    # tc = TwitterCounter.new('reagent')
    
    
  end
  
end

class UserTest < Test::Unit::TestCase
  
  def test_should_be_able_to_retrieve_follower_count_from_json_response
    json_data =<<-EOF
      {
        "user_id": "50812",
        "user_name": "reagent",
        "url": "http://sneaq.net",
        "avatar": "http://a3.twimg.com/profile_images/431511849/professional_mutha_normal.jpg",
        "followers_current": "205"
      }
    EOF
    
    user = User.new(json_data)
    assert_equal '205', user.follower_count
  end
  
end

class User
  
  def initialize(json_data)
    @json = JSON.parse(json_data)
  end
  
  def follower_count
    @json['followers_current']
  end
  
end

class TwitterCounter
  
  def self.for(username)
    tc = TwitterCounter.new(username)
    user = User.new(tc.response)
    
    user.follower_count
  end
  
  def initialize(username)
    @username = username
  end
  
  def url
    "http://twittercounter.com/api/?username=#{@username}&output=json"
  end
  
  def endpoint
    URI.parse(url)
  end
  
  def response
    Net::HTTP.get(endpoint)
  end
  
  
end