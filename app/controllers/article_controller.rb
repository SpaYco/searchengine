class ArticleController < ApplicationController
  before_action :check_session, only: [:search]

  def index
    @articles = Article.all.first(50)
  end

  def search
    articles = Article.where('title LIKE ?', "%#{params[:query]}%").first(50)
    render(partial: 'articles', locals: { articles: articles })
    save_search(params[:query], session[:user_id])
  end

  private

  def save_search(query, session)
    return if query.nil? || query.length < 3

    recent_search = Search.new(user_params)
    recent_search.session_id = session
    session_searches = Search.where(session_id: session)
    if session_searches.empty?
      recent_search.save
      return
    else
      new_search = true
      session_searches.each do |search|
        next unless search.searched?(query)

        new_search = false
        recent_search = search
        recent_search.update(query: query)
        break
      end
    end
    recent_search.save
  end

  def user_params
    params.permit(:query)
  end

  def check_session
    session[:user_id] = SecureRandom.urlsafe_base64(16) if session[:user_id].nil?
  end
end
