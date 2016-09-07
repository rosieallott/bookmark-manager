require 'spec_helper'

feature 'filtering tags' do

  scenario 'user can view links by tag' do
    Link.create(url: 'www.facebook.com', title: 'Facebook', tags: [Tag.create(name: 'bubbles')] )
    Link.create(url: 'www.twitter.com', title: 'Twitter', tags: [Tag.create(name: 'social-media')] )

    visit '/tags/bubbles'

    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content('Facebook')
      expect(page).not_to have_content('Twitter')
    end
  end

end
