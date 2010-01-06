class AddParentIdToSubpages < ActiveRecord::Migration
  def self.up
    add_column :subpages, :parent_id, :integer
  end

  def self.down
    remove_column :subpages, :parent_id
  end
end
