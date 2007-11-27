class OauthController < ApplicationController
  before_filter :verify_oauth_consumer_signature, :only => :request_token
  before_filter :verify_oauth_request_token,      :only => :access_token
  
  def access_token
    # TODO this does a straight token exchange
    # in a real application, you'd want to ensure that the request token has been authorized
    
    consumer = oauth_token.consumer
    
    # destroy the existing request token
    oauth_token.destroy
    
    # create a new access token
    # this is where an existing access token for an app would be loaded in order to share it between devices
    token = consumer.access_tokens.create!
      
    render :text => "oauth_token=#{token.token}&oauth_token_secret=#{token.secret}"
  end
  
  def authorize
    # TODO implement me
  end
  
  def request_token
    consumer = OauthConsumer.find(:first)
    
    token = consumer.request_tokens.create!
    
    render :text => "oauth_token=#{token.token}&oauth_token_secret=#{token.secret}"
  end
end
