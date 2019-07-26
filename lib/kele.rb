require 'HTTParty'
require 'json'

class Kele
include HTTParty


  def initialize(username, password) 
  	@base_uri = "https://www.bloc.io/api/v1"
  	response = Kele.post("#{@base_uri}/sessions",body: {email: username, password: password})
  	@auth_token = response["auth_token"]
  	if @auth_token == nil
  	  raise 'Invalide Credentials'
  	end
  end

  def get_me
  	response = self.class.get("#{@base_uri}/users/me", headers: { "authorization" => @auth_token })
  	obj = JSON.parse(response.body)
  	p obj.class 
  end  
end