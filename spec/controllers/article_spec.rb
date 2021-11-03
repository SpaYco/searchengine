require 'capybara/rspec'
require 'rails_helper'

describe 'Articles', type: :feature do
  before(:each) do |idx|
    50.times do
      Article.create(
        title: "title#{idx}",
        body: Faker::Lorem.paragraph(sentence_count: 10)
      )
    end
  end

  it 'should have a title' do
    visit '/'
    expect(page).to have_content('title')
  end

  it 'should have a body' do
    visit '/'
    expect(page).to have_content('body')
  end
end
