require 'capybara/rspec'
require 'rails_helper'

describe 'Articles', type: :feature do
  
  title = Faker::Game.title
  paragraph = Faker::Lorem.paragraph(sentence_count: 10)
  short_paragraph = 'word'
  long_paragraph = Faker::Lorem.paragraph(sentence_count: 100)

  it 'is valid with valid data' do
    article = Article.new(title: title, body: paragraph)
    expect(article).to be_valid
  end

  it 'is not valid without title' do
    article = Article.new(body: paragraph)
    expect(article).to_not be_valid
  end
  
  it 'is not valid if title is less than 5' do
    article = Article.new(title: short_paragraph, body: paragraph)
    expect(article).to_not be_valid
  end
  
  it 'is not valid if title is more than 50' do
    article = Article.new(title: long_paragraph, body: paragraph)
    expect(article).to_not be_valid
  end

  it 'is not valid without body' do
    article = Article.new(title: title)
    expect(article).to_not be_valid
  end
  
  it 'is not valid if body is less than 10' do
    article = Article.new(title: title, body: short_paragraph)
    expect(article).to_not be_valid
  end
  
  it 'is not valid if body is more than 300' do
    article = Article.new(title: title, body: long_paragraph)
    expect(article).to_not be_valid
  end


end