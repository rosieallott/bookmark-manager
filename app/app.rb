require 'sinatra/base'
require_relative 'models/link'

class Bookmark < Sinatra::Base

  get '/' do
    redirect '/home'
  end

  get '/home' do
    @links = Link.all
    erb(:home)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
