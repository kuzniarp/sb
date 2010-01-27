class Admin::PhotoController < ApplicationController
	layout 'admin'
	before_filter :authorize
	
	def upload
		if request.post?
			params[:files].each do |index,file|
				if file != ''
					photo = Photo.new(:photo_file => file, :album_id => params[:album_id])
					photo.save
				end
			end
			redirect_to :controller => 'album', :action => 'edit', :id => params[:album_id]
		end
	end
	
	def delete
		Photo.find_by_id(params[:id]).destroy
		redirect_to :controller => 'album', :action => 'edit', :id => params[:album_id]
	end
	
	def update_name
		@photo = Photo.find_by_id(params[:id])
		@photo.name = params[:value]
		@photo.send('update')
		render :layout => false, :inline => "<%= @photo.name.to_s == '' ? 'pusta nazwa...' : @photo.name %>" 
	end
	
	def update_description
		@photo = Photo.find_by_id(params[:id])
		@photo.description = params[:value]
		@photo.send('update')
		render :layout => false, :inline => "<%= @photo.description.to_s == '' ? 'pusty opis...' : @photo.description %>" 
	end

  def order
		params["photo_list"].each_with_index do |id,i|
			photo = Photo.find_by_id(id)
      photo.update_attribute(:photo_order,i) if photo
		end
		render :nothing => true
 end
end
