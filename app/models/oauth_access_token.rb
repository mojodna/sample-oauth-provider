class OauthAccessToken < OauthToken
  def access_token?
    true
  end
end