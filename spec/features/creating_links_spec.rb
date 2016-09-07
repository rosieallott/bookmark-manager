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
  scenario 'add one tag to new link' do
    add_link
    fill_in 'tag', with: 'life invader'
    click_button 'Add link'
    link = Link.first
    within 'ul#links' do
      expect(link.tags.map(&:name)).to include('life invader')
    end
  end
  scenario 'add two tags to new link' do
    add_link
    fill_in 'tag', with: 'social-media, fun'
    click_button 'Add link'
    link = Link.first
    visit '/links'
    within 'ul#links' do
      expect(link.tags.map(&:name)).to include('social-media')
      expect(link.tags.map(&:name)).to include('fun')
    end
  end

end
