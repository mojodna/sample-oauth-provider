ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'mocha'

class Test::Unit::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  # If you need to control the loading order (due to foreign key constraints etc), you'll
  # need to change this line to explicitly name the order you desire.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherent this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def stub_oauth!
    # stub out OAuth signature verification
    @controller.stubs(:verify_oauth_consumer_signature).returns(true)
    @controller.stubs(:verify_oauth_signature).returns(true)
  end

  # Make an OAuth request with a specified token.
  def with_oauth_token(token, &block)
    oauth_token = token.is_a?(Symbol) ? oauth_tokens(token) : token

    # oauth-provided attributes are used to retrieve data, so stub them
    @controller.stubs(:oauth_token).returns(oauth_token)
    @controller.stubs(:oauth_consumer).returns(oauth_token.app)

    yield [oauth_token, oauth_token.app]
  end
end