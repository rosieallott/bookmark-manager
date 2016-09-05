require 'sinatra/base'
require_relative 'models/link'

class Bookmark < Sinatra::Base

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb(:links)
  end

  get '/links/new' do
    erb(:links_new)
  end

  post '/links' do
    Link.create(:address => params[:address], :title => params[:title])
    redirect '/links'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
