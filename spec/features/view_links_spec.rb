require 'spec_helper'

feature 'lists links' do
  scenario 'shows a list of links on homepage' do
    Link.create(url: 'https://www.facebook.com/home.php', title: 'Facebook')
    visit '/links'

    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content('Facebook')
    end
  end
end
