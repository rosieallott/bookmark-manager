require 'sinatra/base'
require_relative 'datamapper_setup'

ENV['RACK_ENV'] ||= 'development'

class BookmarkManager < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    array = params[:tag].split(", ")
      array.each do |t|
        tag = Tag.first_or_create(name: t)
        link.tags << tag
      end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/sign-up' do
    erb :signup
  end


  run! if app_file == $0


end
