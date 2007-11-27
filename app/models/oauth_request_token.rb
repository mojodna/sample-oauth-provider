class OauthRequestToken < OauthToken
  def request_token?
    true
  end
end