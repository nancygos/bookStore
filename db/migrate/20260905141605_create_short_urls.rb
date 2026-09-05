class CreateShortUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :short_urls do |t|
      t.string :long_url
      t.string :short_code
      t.integer :user_id
      t.datetime :expires_at

      t.timestamps
    end
  end
end
