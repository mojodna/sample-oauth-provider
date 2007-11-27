class User < ActiveRecord::Base
  has_many :consumer, :class_name => "OAuthConsumer", :foreign_key => "author_id"
  has_many :tokens, :class_name => "OAuthToken"
end
