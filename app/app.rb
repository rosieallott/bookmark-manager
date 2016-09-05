require 'sinatra/base'

class Bookmark < Sinatra::Base

  get '/' do
    redirect '/home'
  end

  get '/home' do
    erb(:home)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
