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

  get '/sessions/reset' do
    erb :'sessions/reset'
  end

  post '/sessions/reset' do
    user = User.first(email: params[:email])
    if user
      #generate token
    else
      flash[:notice] = 'Not a known user'
    end 
    redirect '/sessions/password_reset'
  end

  get '/sessions/password_reset' do
    #check token = token and time < time(0)+1hr
    #allow to enter new password
    erb :'sessions/password_reset'
  end

  post '/sessions/password_reset' do
    #store new password
    redirect '/links'
  end

end
