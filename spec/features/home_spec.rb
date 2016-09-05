require 'spec_helper'

feature 'Feature test - Homepage' do
  scenario 'Loads a list of links' do
    Link.create(:address => 'www.google.com', :title => 'Google')
    visit '/links'
    expect(page.status_code).to eq 200
    expect(page).to have_text("Welcome to your bookmarks!")
    within 'ul#links' do
      expect(page).to have_content("Google")
    end
  end
end
