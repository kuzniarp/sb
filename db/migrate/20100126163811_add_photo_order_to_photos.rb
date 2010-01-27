class AddPhotoOrderToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :photo_order, :integer
  end

  def self.down
    remove_column :photos, :photo_order
  end
end
