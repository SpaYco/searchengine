require 'capybara/rspec'
require 'rails_helper'

describe 'Articles', type: :feature do
  session_id = SecureRandom.urlsafe_base64(16)
  before(:each) do |idx|
    50.times do
      Search.create(
        query: "title#{idx}",
        session_id: session_id
      )
    end
  end

  it 'should have a search' do
    visit '/search'
    expect(page).to have_content('Search')
  end

  it 'should list only top 100 queries' do
    100.times do |n|
      2.times do
        Search.create(
          query: "query#{n}",
          session_id: session_id
        )
      end
    end

    visit '/search'
    expect(page).to have_content('query0')
    expect(page).to have_content('query99')
  end

  it 'should not list queries not in top 100' do
    100.times do |n|
      2.times do
        Search.create(
          query: "query#{n}",
          session_id: session_id
        )
      end
    end

    Search.create(
      query: 'least_used',
      session_id: session_id
    )
    visit '/search'
    expect(page).to_not have_content('least_used')
  end
end
