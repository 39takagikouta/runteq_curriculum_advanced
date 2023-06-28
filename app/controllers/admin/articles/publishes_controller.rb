class Admin::Articles::PublishesController < ApplicationController
  layout 'admin'

  before_action :set_article

  def update
    @article.published_at = Time.current unless @article.published_at?
    if @article.published_at > Time.now
      @article.set_publish_wait_state
    elsif @article.published_at < Time.now
      @article.set_published_state
    end

    if @article.valid?
      Article.transaction do
        @article.body = @article.build_body(self)
        @article.save!
      end

      if @article.state == "publish_wait"
        flash[:notice] = '公開待ちにしました'
      elsif @article.state == "published"
        flash[:notice] = '公開しました'
      end

      redirect_to edit_admin_article_path(@article.uuid)
    else
      flash.now[:alert] = 'エラーがあります。確認してください。'

      @article.state = @article.state_was if @article.state_changed?
      render 'admin/articles/edit'
    end
  end

  private

  def set_article
    @article = Article.find_by!(uuid: params[:article_uuid])
  end
end
