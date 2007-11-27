class CreateOauthConsumers < ActiveRecord::Migration
  def self.up
    create_table :oauth_consumers do |t|
      t.integer :author_id
      t.string  :key
      t.string  :secret
      t.timestamps
    end
  end

  def self.down
    drop_table :oauth_consumers
  end
end
