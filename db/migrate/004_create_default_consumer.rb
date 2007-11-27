class CreateDefaultConsumer < ActiveRecord::Migration
  def self.up
    OauthConsumer.transaction do
      default_user = User.create!(:name => "Default User")
      OauthConsumer.create! \
        :author => default_user,
        :key    => "key",
        :secret => "secret"
    end
  end

  def self.down
  end
end
