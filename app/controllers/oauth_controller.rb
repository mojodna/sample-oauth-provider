class OauthController < ApplicationController
  before_filter :verify_oauth_consumer_signature, :only => :request_token
  before_filter :verify_oauth_request_token,      :only => :access_token

  def access_token
    # TODO this does a straight token exchange
    # in a real application, you'd want to ensure that the request token has been authorized

    consumer = oauth_token.consumer

    # check the verifier
    raise Exception if oauth_token.verifier != oauth_request_proxy.oauth_verifier

    # destroy the existing request token
    oauth_token.destroy

    # create a new access token
    # this is where an existing access token for an app would be loaded in order to share it between devices
    token = consumer.access_tokens.create!

    render :text => "oauth_token=#{token.token}&oauth_token_secret=#{token.secret}"
  end

  def authorize
    # TODO implement me

    token = OauthRequestToken.find_by_token(params[:oauth_token])

    return unless request.post?

    # generate a random 16-character string
    chars = ("0".."9").to_a + ("a".."z").to_a
    s = ""
    16.times { s << chars[rand(36)] }

    token.update_attributes(:validated => true, :verifier => s)

    # Note: this doesn't work for callbacks that already contain ?'s
    redirect_to token.callback_url + "?oauth_verifier=#{s}"
  end

  def request_token
    consumer = OauthConsumer.find(:first)

    token = consumer.request_tokens.create!(:callback_url => oauth_request_proxy.oauth_callback)

    render :text => "oauth_token=#{token.token}&oauth_token_secret=#{token.secret}&oauth_callback_confirmed=true"
  end
end
