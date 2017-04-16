ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  ##########################################################
  # Methods that will allow our tests to pass in the case 
  # we have to log in in order to perform some functions.
  # 'login_as' will only be called if 'session' is defined  
  ##########################################################
  def login_as(user, password)
    post login_url, params: { 
    	email: user.email, password: password }
  end
  
  def logout
    delete logout_url
  end
  
  def setup
  	login_as users(:one), 'secret'
  end
end
