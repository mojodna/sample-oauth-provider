class CreateOauthTokens < ActiveRecord::Migration
  def self.up
    create_table :oauth_tokens do |t|
      t.integer :consumer_id
      t.integer :user_id
      t.string  :token
      t.string  :secret
      t.string  :type
      t.timestamps
    end
  end

  def self.down
    drop_table :oauth_tokens
  end
end
