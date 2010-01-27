require "ftools"
class Photo < ActiveRecord::Base
	belongs_to :album
	before_update :update_url_name
	after_save :write_file, :update_photo_data
	after_destroy :delete_file
  before_save :set_photo_order

	PHOTO_STORAGE_PATH = "#{RAILS_ROOT}/public/uploads/photos"
	THUMBNAIL_WIDTH = 100
	THUMBNAIL_HEIGHT = 75 #66
	GALLERY_IMAGE_WIDTH = 460
	GALLERY_IMAGE_HEIGHT = 345 #307
	FULL_IMAGE_WIDTH = 800
	FULL_IMAGE_HEIGHT = 600 #528

  def set_photo_order
    unless self.photo_order
      self.photo_order = self.album.photos.count
    end
  end

	def update_url_name
		self.url_name = UnicodeNormalizer.normalize self.name
	end
	
	def update_photo_data
		self.name = "#{self.album.name} #{self.id}" if self.name.nil?
		self.description = self.album.description if self.description.nil?
		update_url_name
		update
	end
	# setter for form file field "cover"
	# grabs the data and sets it to an instance variable.
	# we need this so the model is in db before file save,
	# so we can use the model id as filename.
	def photo_file=(file_data)
		@file_data = file_data
	end
	
	# write the @file_data data content to disk,
	# using the ALBUM_COVER_STORAGE_PATH constant.
	# saves the file with the filename of the model id
	# together with the file original extension
	def write_file
		if @file_data
			self.file = "#{id}.#{extension}"
			File.makedirs("#{PHOTO_STORAGE_PATH}/#{self.album.url_name}")
			File.open("#{PHOTO_STORAGE_PATH}/#{self.album.url_name}/#{self.file}", "wb") { |file| file.write(@file_data.read) }
			update
			create_gallery_images
			# put calls to other logic here - resizing, conversion etc.
		end
	end
	
	# deletes the file(s) by removing the whole dir
	def delete_file
		original_image_path = "#{PHOTO_STORAGE_PATH}/#{self.album.url_name}/#{self.file}"
		thumbnail_path = "#{PHOTO_STORAGE_PATH}/#{self.album.url_name}/thumbnail_#{self.file}"
		gallery_image_path = "#{PHOTO_STORAGE_PATH}/#{self.album.url_name}/gallery_image_#{self.file}"
		[original_image_path, thumbnail_path, gallery_image_path].each do |file|
			FileUtils.rm(file) if File.exist?(file)
		end
	end
	
	# just gets the extension of uploaded file
	def extension
		@file_data.original_filename.split(".").last
	end  
	
	def file_url
		"/uploads/photos/#{self.album.url_name}/#{self.file}"
	end
	
	def thumbnail_url
		"/uploads/photos/#{self.album.url_name}/thumbnail_#{self.file}"
	end
	
	def gallery_image_url
		"/uploads/photos/#{self.album.url_name}/gallery_image_#{self.file}"
	end
	
	def get_link_options
		{:subpage_url_name => self.album.gallery.url_name, :album_url_name => self.album.url_name, :url_name => self.url_name}
	end
	
	private
	
	def create_gallery_images
		storage_path = "#{PHOTO_STORAGE_PATH}/#{self.album.url_name}"
		
		thumbnail = Magick::Image.read("#{storage_path}/#{self.file}").first
		#thumbnail.crop_resized!(THUMBNAIL_WIDTH, THUMBNAIL_HEIGHT, Magick::CenterGravity)
		thumbnail.change_geometry!("#{THUMBNAIL_WIDTH}x#{THUMBNAIL_HEIGHT}") { |cols, rows, img|
		 img.resize!(cols, rows)
		}		 
		thumbnail.write("#{storage_path}/thumbnail_#{self.file}")

		gallery_image = Magick::Image.read("#{storage_path}/#{self.file}").first
		#gallery_image.crop_resized!(GALLERY_IMAGE_WIDTH, GALLERY_IMAGE_HEIGHT, Magick::CenterGravity)
		#gallery_image = add_watermark gallery_image
		gallery_image.change_geometry!("#{GALLERY_IMAGE_WIDTH}x#{GALLERY_IMAGE_HEIGHT}") { |cols, rows, img|
		 img.resize!(cols, rows)
		}		 
		gallery_image.write("#{storage_path}/gallery_image_#{self.file}")
		
		original_image = Magick::Image.read("#{storage_path}/#{self.file}").first
		#original_image.crop_resized!(FULL_IMAGE_WIDTH, FULL_IMAGE_HEIGHT, Magick::CenterGravity)
		#original_image = add_watermark original_image
		original_image.change_geometry!("#{FULL_IMAGE_WIDTH}x#{FULL_IMAGE_HEIGHT}") { |cols, rows, img|
		 img.resize!(cols, rows)
		}		 
		original_image.write("#{storage_path}/#{self.file}")
	end
	
	def add_watermark image
		mark = Magick::Image.new(240, 80) do
			self.background_color = 'none'
		end
		gc = Magick::Draw.new
		gc.annotate(mark, 0, 0, 0, 0, "www.koarti.pl") do
			self.gravity = Magick::CenterGravity
			self.pointsize = 100
			self.font_family = "Courier"
			self.font_weight = 400
			self.fill = "white"
			self.stroke = "none"
		end
		#mark.rotate!(-90)
		
		image.watermark(mark, 0.1, 0, Magick::CenterGravity)
	end
end
