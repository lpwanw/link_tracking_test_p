class CreateLinkClicks < ActiveRecord::Migration[8.0]
  def change
    create_table :link_clicks do |t|
      t.string :url, null: false, index: true
      t.string :anchor_text, null: false
      t.string :referrer, null: false
      t.string :user_agent, null: false
      t.string :ip_address, null: false

      t.timestamps
    end

    add_index :link_clicks, :created_at
  end
end
