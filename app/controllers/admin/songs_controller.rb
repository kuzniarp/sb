class Admin::SongsController < ApplicationController
	layout 'admin'
	before_filter :authorize

  def create
    song = Song.create(params[:song])
    redirect_to :controller => 'subpage', :action => 'edit', :id => song.mediapage_id
  end

	def order
		params["song_list"].each_with_index do |id,i|
			Song.find_by_id(id).update_attribute(:song_order,i)
		end
		render :nothing => true	
 end


	def delete
		song = Song.find_by_id(params[:id])
    song.destroy
		redirect_to :controller => 'subpage', :action => 'edit', :id => song.mediapage_id
	end

	def update_name
		@song = Song.find_by_id(params[:id])
		@song.name = params[:value]
		@song.send('update')
		render :layout => false, :inline => "<%= @song.name.to_s == '' ? 'pusta nazwa...' : @song.name %>"
	end

	def update_description
		@song = Song.find_by_id(params[:id])
		@song.description = params[:value]
		@song.send('update')
		render :layout => false, :inline => "<%= @song.description.to_s == '' ? 'pusty opis...' : @song.description %>"
	end
end
