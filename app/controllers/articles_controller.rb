class ArticlesController < ApplicationController 
    skip_before_action :authorize!,  only: [:index, :show]

    def index
        articles = Article.recent.page(params[:page]).per(params[:per_page])
        json_string = ArticleSerializer.new(articles).serializable_hash.to_json
        render json: json_string 
    end

    def show
        render json: Article.find(params[:id])
    end
end