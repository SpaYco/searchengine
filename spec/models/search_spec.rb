require 'capybara/rspec'
require 'rails_helper'

describe 'Searches', type: :feature do
  long_paragraph = Faker::Lorem.paragraph(sentence_count: 100)
  session_id = SecureRandom.urlsafe_base64(16)

  it 'is valid with valid data' do
    search = Search.new(query: 'test', session_id: session_id)
    expect(search).to be_valid
  end

  it 'is not valid without query' do
    search = Search.new(session_id: session_id)
    expect(search).to_not be_valid
  end
  
  it 'is not valid if query is less than 3' do
    search = Search.new(query: 'te', session_id: session_id)
    expect(search).to_not be_valid
  end
  
  it 'is not valid if query is more than 50' do
    search = Search.new(query: long_paragraph, session_id: session_id)
    expect(search).to_not be_valid
  end

  it 'is not valid without session_id' do
    search = Search.new(query: 'test')
    expect(search).to_not be_valid
  end
end