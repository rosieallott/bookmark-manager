require 'sinatra/base'
require_relative 'models/link'

ENV['RACK_ENV'] ||= 'development'

# require 'bundler'
# Bundler.require :default, ENV['RACK_ENV'].to_sym

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
