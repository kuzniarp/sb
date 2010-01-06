class CreateSubpages < ActiveRecord::Migration
  def self.up
    create_table :subpages do |t|
    t.string :name
	  t.string :header
	  t.text :description
	  t.string :url_name
	  t.string :type
	  t.integer :page_order
    end
  end

  def self.down
    drop_table :subpages
  end
end
