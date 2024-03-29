require 'HTTParty'
require 'json'
require_relative 'roadmap'

class Kele
include HTTParty
include Roadmap

# mentor_id"=>2292457
# chain_id"=>7019
#Mike id 2370372

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
  end  
  
  def get_mentor_availability(mentor_id)
  	# https://private-anon-56a5d4037e-blocapi.apiary-mock.com/api/v1/mentors/id/student_availability
    response = self.class.get("#{@base_uri}/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    availability = JSON.parse(response.body)["slots"]
  end

  def get_messages(page = nil)
  	 if page.nil?
  	 response = self.class.get("#{@base_uri}/message_threads/", headers: { "authorization" => @auth_token })
  	 else
  	 response = self.class.get("#{@base_uri}/message_threads/", headers: { "authorization" => @auth_token }, body: {page: page})
  	 end
  	 messages = JSON.parse(response.body)
  end

  def create_message(username, recipient_id, stripped_text, subject = nil, token = nil) 
  	 body = {"stripped-text" => stripped_text,
  	 	    "recipient_id" => recipient_id,
  	 	    "sender" => username}

  	 	   body[:subject] = subject if subject != nil
           body[:token] = token if token != nil

     response = self.class.post("#{@base_uri}/messages/",{
     	headers: { "authorization" => @auth_token }, 
     	body: body})
  end
  
  def get_remaining_checkpoints(chain_id)
  	response = self.class.get("#{@base_uri}/enrollment_chains/#{chain_id}/checkpoints_remaining_in_section", headers: { "authorization" => @auth_token })
    remaining = JSON.parse(request.body)
  end

end