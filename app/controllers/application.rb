# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => '5d2393a228686e4193613dbcdf32883c'

protected

  # # Log a user in based on their oauth token (acts_as_authenticated-style)
  # def log_user_in
  #   current_user = oauth_token.user if oauth_token
  # end

  ## OAuth implementation

  def oauth_consumer
    @oauth_consumer
  end

  def oauth_token
    @oauth_token
  end

  # verifies a request token request
  def verify_oauth_consumer_signature
    valid = OAuth::Signature.verify(request) do |token, consumer_key|
      @oauth_consumer = OauthConsumer.find_by_key(consumer_key)

      # return the token secret and the consumer secret
      [nil, oauth_consumer.secret]
    end
    
    # TODO catch different tyes of errors
  # rescue OAuth::UnknownSignatureMethod

    render :text => "Invalid OAuth Request", :status => 401 unless valid
  end

  def verify_oauth_request
    verify_oauth_signature && oauth_token.is_a?(OauthAccessToken)
  end

  def verify_oauth_request_token
    verify_oauth_signature && oauth_token.is_a?(OauthRequestToken)
  end

private

  # Implement this for your own application using app-specific models
  def verify_oauth_signature
    valid = OAuth::Signature.verify(request) do |token|
      @oauth_token = OauthToken.find_by_token(token, :include => :consumer)
      @oauth_consumer = @oauth_token.consumer

      # return the token secret and the consumer secret
      [oauth_token.secret, oauth_consumer.secret]
    end

    render :text => "Invalid OAuth Request", :status => 401 unless valid
  end
end