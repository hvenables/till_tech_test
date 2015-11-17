require 'sinatra/base'
require 'json'
require_relative 'app/till.rb'

class TillApp < Sinatra::Base

  get '/' do
    'Hello TillApp!'
  end

  get '/menu' do
    @till = Till.new('hipstercoffee.json')
    @cafe_name = @till.show
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
