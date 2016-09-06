def add_link
  visit '/links/new'
  fill_in 'url', with: 'http://www.facebook.com/'
  fill_in 'title', with: 'Facebook'
end
