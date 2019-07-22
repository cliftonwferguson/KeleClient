require 'HTTParty'

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
end