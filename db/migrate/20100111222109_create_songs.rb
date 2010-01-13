class CreateSongs < ActiveRecord::Migration
  def self.up
    create_table :songs do |t|
      t.string :name
      t.text :description
      t.integer :song_order
      t.integer :mediapage_id
      t.string :clip_file_name
      t.string :clip_content_type
      t.integer :clip_file_size
      t.datetime :clip_updated_at
    end
  end

  def self.down
    drop_table :songs
  end
end
