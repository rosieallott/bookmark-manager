class BookMark < Sinatra::Base

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/links'
    else
      flash.now[:notice] = "Username or password is not correct"
      erb :'sessions/new'
    end
  end

  delete '/sessions/sign_out' do
    session[:user_id] = nil
    flash[:notice] = 'Goodbye!'
    redirect '/links'
  end

end
