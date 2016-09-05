

feature 'lists links' do
  scenario 'shows a list of links on homepage' do
    Link.create(url: 'https://www.facebook.com/home.php', title: 'Facebook')
    Link.create(url: 'https://www.google.co.uk', title: 'Google')
    visit '/home'

    expect(page.status_code).to eq 200

    within 'ul#home' do
      expect(page).to have_content('Facebook')
      expect(page).to have_content('Google')
    end
  end
end
