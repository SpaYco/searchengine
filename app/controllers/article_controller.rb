class ArticleController < ApplicationController
  before_action :check_session, only: [:search]

  def index
    @articles = Article.all
  end

  def search
    articles = Article.where("title LIKE ?", "%#{params[:query]}%")
    render(partial: 'articles', locals: { articles: articles })
    save_search(params[:query], session[:user_id])
  end

  private
  def save_search(query, session_id)
    if query == '' || query == nil || query.length < 3
      search = Search.new(user_params)
      return
    end
    recent_search = Search.new(user_params)
    recent_search.session_id = session_id
    session_searches = Search.where(session_id: session_id)
    if session_searches.empty?
      recent_search.save
      return
    else
      new_search = true
      session_searches.each do |search|
        if search.searched?(query)
          new_search = false
          recent_search = search
          recent_search.update(query: query)
          break
        end
      end
    end
    recent_search.save
  end

  def user_params
    params.permit(:query)
  end

  def check_session
    if session[:user_id] == nil
      session[:user_id] = SecureRandom.urlsafe_base64(16)
    end
  end
end
