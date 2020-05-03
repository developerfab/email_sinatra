require 'dotenv/load'
require 'pony'
require 'sinatra'
require 'sinatra/json'
require 'json'

before do
  message = request.body.read
  @params = JSON.parse(message, symbolize_names: true) if message
end

post '/payments/compensations' do
  subject = filter_message
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

def filter_message
  if status_payment == 'supported'
    supported_compensation_payment 
  else
    unsupported_compensation_payment
  end
end

def unsupported_compensation_payment
  "Pago de compensanción no admitido para servicio de #{service}"
end

def supported_compensation_payment
  "Pago de compensanción admitido para servicio de #{service}"
end

def message
  @params[:message]
end

def email
  @params[:email]
end

def service
  @params[:service]
end

def status_payment
  @params[:status_payment]
end
