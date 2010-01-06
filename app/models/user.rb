require "digest/sha1"
class User
	attr_accessor :id, :email, :password 
	USERS = {'admin1' => {:id => 1, :email => 'admin', :password => '1beac40020e67d7109b160bbbce41ac112c106e0'}, 'admin2' => {:id => 2, :email => 'admin2', :password => '7805d29200c250cf9b2e2550506506e2e1119632'}}
	
	def self.authenticate email, password
		User::USERS.values.map{|u| {:email => u[:email], :password => u[:password]}}.include?({:email => email, :password => Digest::SHA1.hexdigest(password)})
	end
end