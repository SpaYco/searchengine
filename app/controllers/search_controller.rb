class SearchController < ApplicationController
  def index
    @grouped_searches = Search.group(:query).count
    p '=========================='
    p @grouped_searches
    p '=========================='
  end
end
