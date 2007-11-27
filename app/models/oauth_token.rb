class OauthToken < ActiveRecord::Base
  belongs_to :consumer, :class_name => "OauthConsumer", :foreign_key => "consumer_id"
  belongs_to :user
  
  validates_presence_of :token, :secret
  
  def after_initialize
    if new_record?
      generate_token_and_secret
    end
  end
  
  def access_token?
    false
  end

  def request_token?
    false
  end
  
protected

  def generate_token_and_secret
    self.token  = random_string(12)
    self.secret = random_string(32)
  end
  
  def random_string(length = 20)
    str = ""
    length.times do
      str << rand(36).to_s(36)
    end
    str
  end
end
