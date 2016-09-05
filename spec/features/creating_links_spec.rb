require 'spec_helper'

feature 'adding links' do
  scenario 'add link including address and title' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.facebook.com/'
    fill_in 'title', with: 'Life Invader'
    click_button 'Add link'

    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_content('Life Invader')
    end
  end
end
