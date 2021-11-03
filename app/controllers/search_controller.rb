class SearchController < ApplicationController
  def index
    @grouped_searches = Search.group(:query).pluck("query, count(query) as COUNT").sort_by { |a| a[1] }.reverse.first(100)
  end
end
