class SearchController < ApplicationController
  def index
    @articles = Article.all
  end
end
