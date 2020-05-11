require 'dotenv/load'
require 'pony'
require 'sinatra'
require 'sinatra/json'
require 'json'

before do
  message = request.body.read
  @params = JSON.parse(message, symbolize_names: true) if message
end

post '/send_email' do
  result = send_message(subject)

  response = if result
    { message: result }
  else
    { message: result.errors }
  end

  json response
end

def send_message(subject)
  Pony.mail({
    :to => email,
    :body => message,
    :subject => subject,
    :via => :smtp,
    :via_options => {
      :address        => 'smtp.gmail.com',
      :port           => '587',
      :user_name      => ENV['USERNAME'],
      :password       => ENV['PASSWORD'],
      :authentication => :plain,
      :domain         => "localhost"
    }
  })
end

def message
  @params[:message]
end

def email
  @params[:email]
end

def subject
  @params[:subject]
end
