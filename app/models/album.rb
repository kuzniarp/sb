class Album < ActiveRecord::Base
	include ActionView::Helpers::SanitizeHelper
	validates_presence_of :name
	validates_uniqueness_of :name
	has_many :photos, :dependent => :destroy, :order => :photo_order
	belongs_to :gallery
	has_one :meta_tag, :as => :content
	
	before_save :update_url_name
	after_destroy :remove_photo_files
	
  def remove_photo_files
    FileUtils.remove_dir("#{Photo::PHOTO_STORAGE_PATH}/#{self.url_name}") if File.exist?("#{Photo::PHOTO_STORAGE_PATH}/#{self.url_name}/")
  end

	def update_url_name
		self.url_name = UnicodeNormalizer.normalize self.name
		move_album_photos
	end
	
	def move_album_photos
		if self.id
			old_url_name = Album.find_by_id(self.id).url_name
			FileUtils.mv("#{Photo::PHOTO_STORAGE_PATH}/#{old_url_name}/", "#{Photo::PHOTO_STORAGE_PATH}/#{self.url_name}/") if File.exist?("#{Photo::PHOTO_STORAGE_PATH}/#{old_url_name}/") and old_url_name != self.url_name
		end
	end
	
	alias_method :old_meta_tag, :meta_tag

	def meta_tag
		old_meta_tag || default_meta_tag
	end	
	
	def default_meta_tag
		MetaTag.new(:title => "#{self.gallery.name if self.gallery} - #{self.name}", :description => "#{self.get_default_meta_tag_description}", :keywords => "#{self.name}", :content_type => self.class.base_class.to_s, :content_id => self.id)
	end
	
	def get_link_options
		{:subpage_url_name => self.gallery.url_name, :url_name => self.url_name}
	end
	
	def get_default_meta_tag_description
		strip_tags(self.description.to_s)[/[A-Z|0-9].+?(\.|\!|\?)/]
	end
end
