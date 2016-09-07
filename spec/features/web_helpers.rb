def add_link
  visit '/links/new'
  fill_in 'url', with: 'http://www.facebook.com/'
  fill_in 'title', with: 'Facebook'
end

def user_signup
  visit '/sign-up'
  fill_in 'username', with: 'Santa'
  fill_in 'email', with: 'santa@northpole.com'
end
