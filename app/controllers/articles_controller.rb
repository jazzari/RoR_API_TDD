class ArticlesController < ApplicationController 

    def index
        articles = Article.recent
        json_string = ArticleSerializer.new(articles).serializable_hash.to_json
        render json: json_string 
    end

    def show
    end
end