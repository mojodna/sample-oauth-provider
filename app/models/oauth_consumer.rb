class OauthConsumer < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  has_many   :access_tokens,  :class_name => "OauthAccessToken",  :foreign_key => "consumer_id"
  has_many   :request_tokens, :class_name => "OauthRequestToken", :foreign_key => "consumer_id"
end
