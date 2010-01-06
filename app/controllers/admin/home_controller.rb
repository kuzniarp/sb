class Admin::HomeController < ApplicationController
	layout 'admin', :except => [:login]
  layout 'login', :only => [:login]
	before_filter :authorize, :except => [:login]
	
	def login
		if request.post?
			if User.authenticate(params[:user][:email], params[:user][:password])
				session[:user_id] = true
				redirect_to :controller => 'subpage', :action => 'index'
			end
		end
	end
	
	def logout
		session[:user_id] = nil
		redirect_to '/admin/login'
	end
end
