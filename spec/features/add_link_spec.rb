require 'spec_helper'

feature 'Feature test - Add link' do
  scenario 'adds a new link with address and title' do
    visit '/links/new'
    fill_in('address', with: 'http://www.ft.com/home/uk')
    fill_in('title', with: 'FT')
    click_button('Submit')
    within 'ul#links' do
      expect(page).to have_content("FT")
    end
  end
end
