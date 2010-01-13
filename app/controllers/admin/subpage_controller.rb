class Admin::SubpageController < ApplicationController
	layout 'admin'
	before_filter :authorize
	
	def index
		@subpages = Subpage.find(:all)
	end
	
	def edit
		if request.post?
			if params[:subpage] and params[:subpage][:id].to_i > 0
				if @subpage = Subpage.find_by_id(params[:subpage][:id])
					@subpage.type = params[:subpage][:type]
					@subpage.update_attributes(params[:subpage])
				end
				redirect_to :action => 'index'
			else
				params[:subpage][:page_order] = !params[:subpage][:parent_id].blank? ? Subpage.find(params[:subpage][:parent_id]).children.size : Subpage.count
				@subpage = Subpage.new(params[:subpage])
				@subpage.type = params[:subpage][:type]
				@subpage.save
				redirect_to :action => 'edit', :id => @subpage.id
			end
		else
			@subpage = Subpage.find_by_id(params[:id]) || Subpage.new
		end
	end
	
	def order
		params["subpage_list_#{params[:subpage_id]}"].each_with_index do |id,i|
			Subpage.find_by_id(id).update_attribute(:page_order,i)
		end
		render :nothing => true	
  end
	
	def delete
		Subpage.find_by_id(params[:id]).destroy
		redirect_to :action => 'index'
	end
	
	def update_meta_tag
		subpage = Subpage.find_by_id(params[:subpage_id])
		meta_tag = subpage.meta_tag
		meta_tag.update_attribute(params[:attribute], params[:value])
		@output = meta_tag.send(params[:attribute])
		render :layout => false, :inline => "<%= @output.to_s == '' ? '...' : @output %>" 
	end
end
