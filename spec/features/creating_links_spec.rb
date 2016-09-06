require 'spec_helper'

feature 'adding links' do
  scenario 'add link including address and title' do
    add_link
    click_button 'Add link'
    expect(current_path).to eq '/links'
    within 'ul#links' do
      expect(page).to have_content('Facebook')
    end
  end

  scenario 'add tag to new link' do
    add_link
    fill_in 'tag', with: 'life invader'
    click_button 'Add link'
    expect(current_path).to eq '/links'
    within 'ul#links' do
      expect(page).to have_content('life invader')
    end
  end
end
