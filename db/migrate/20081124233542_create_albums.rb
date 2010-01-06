class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
		t.column :name, :string
		t.column :description, :text
		t.column :url_name, :string
		t.column :gallery_id, :integer
		t.column :album_order, :integer
    end
  end

  def self.down
    drop_table :albums
  end
end
