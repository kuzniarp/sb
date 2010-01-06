# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '84da7a448c7d75c36befc6d1dfaf94db'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  before_filter :set_meta_tag

	def authorize
		redirect_to('/admin/login') if session[:user_id].nil?
	end
	
	def set_meta_tag
		#homepage = Subpage.find_by_page_order(0) || Subpage.new
		#homepage_meta_tag = homepage.meta_tag
		#@meta_tag ||= homepage_meta_tag || MetaTag.new
    @meta_tag = (homepage = Subpage.find_by_page_order(0)) ? (homepage.meta_tag ? homepage.meta_tag : MetaTag.new) : MetaTag.new
	end
end
