class AlbumController < ApplicationController
	def show
		album = Album.find_by_url_name(params[:url_name])
		@photos = album ? album.photos : []
		@meta_tag = album.meta_tag if album
	end
	
	def show_photo
		@photo = Photo.find_by_url_name(params[:url_name])
	end
end
