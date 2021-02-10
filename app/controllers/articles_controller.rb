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

    def create 
        article = Article.create!(article_params)

        if article.save
            render json: article, status: :created
        else
            render json: ArticleSerializer.new(article), status: :unprocessable_entity
        end
    end

    private
    def article_params
        params.require(:data).require(:attributes).permit(:title, :content, :slug) ||
             ActionController::Parameters.new 
    end

end