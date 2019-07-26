require 'HTTParty'
require 'json'

class Kele
include HTTParty

# mentor_id"=>2292457

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
  
  def get_mentor_availability(mentor_id)
  	# https://private-anon-56a5d4037e-blocapi.apiary-mock.com/api/v1/mentors/id/student_availability
    response = self.class.get("#{@base_uri}/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    availability = JSON.parse(response.body)["slots"]
    p availability.class
  end


end