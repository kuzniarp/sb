class CreateMetaTags < ActiveRecord::Migration
  def self.up
    create_table :meta_tags do |t|
		t.string :title
		t.string :description
		t.string :keywords
		t.references :content, :polymorphic => true
    end
  end

  def self.down
    drop_table :meta_tags
  end
end
