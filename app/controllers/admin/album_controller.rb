class Admin::AlbumController < ApplicationController
	layout 'admin'
	before_filter :authorize
	
	def index
		@albums = Album.find(:all)
	end
	
	def edit
		if request.post?
			if params[:album] and params[:album][:id].to_i > 0
				if @album = Album.find_by_id(params[:album][:id])
					@album.update_attributes(params[:album])
				end
			else
				params[:album][:album_order] = Album.count
				@album = Album.new(params[:album])
				@album.save
			end
			redirect_to :controller => 'subpage', :action => 'index'
		else
			@album = Album.find_by_id(params[:id]) || Album.new
		end
	end
	
	def order
		params[:album_list].each_with_index do |id,i|
			Album.find_by_id(id).update_attribute(:album_order,i)
		end
		render :nothing => true	
    end
	
	def delete
		Album.find_by_id(params[:id]).destroy
		redirect_to :controller => 'subpage', :action => 'index'
	end
	
	def upload_photos
		redirect_to :controller => 'subpage', :action => 'index'
	end
	
	def update_meta_tag
		album = Album.find_by_id(params[:album_id])
		meta_tag = album.meta_tag
		meta_tag.update_attribute(params[:attribute], params[:value])
		@output = meta_tag.send(params[:attribute])
		render :layout => false, :inline => "<%= @output.to_s == '' ? '...' : @output %>" 
	end
end
