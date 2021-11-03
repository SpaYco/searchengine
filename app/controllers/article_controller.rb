class ArticleController < ApplicationController
  def index
    @articles = Article.all
  end

  def search
    articles = Article.where("title LIKE ?", "%#{params[:title]}%")
    render(partial: 'articles', locals: { articles: articles })
  end
end
