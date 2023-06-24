class Admin::Articles::PreviewsController < ApplicationController
  skip_before_action :require_login

  before_action :preview!

  def show
    binding.irb
    @article = Article.find_by!(uuid: params[:article_uuid])
    binding.irb
    @article.body = @article.build_body(self)
    binding.irb
  end
end
