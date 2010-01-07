require "digest/sha1"
class User
	attr_accessor :id, :email, :password 
	USERS = {'admin1' => {:id => 1, :email => 'admin', :password => 'd7d9718a07a7e21ef24adbc823c188cfa801f9ff'}, 'admin2' => {:id => 2, :email => 'admin2', :password => 'd7d9718a07a7e21ef24adbc823c188cfa801f9ff'}}
	
	def self.authenticate email, password
		User::USERS.values.map{|u| {:email => u[:email], :password => u[:password]}}.include?({:email => email, :password => Digest::SHA1.hexdigest(password)})
	end
end