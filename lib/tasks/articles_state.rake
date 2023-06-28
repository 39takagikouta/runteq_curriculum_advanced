namespace :articles_state do
  desc "公開待ちの中で、公開日時が過去になっているものがあれば、ステータスを「公開」に変更されるようにするタスク"
  task publish_wait_to_published: :environment do
    Article.where(state: "公開待ち").find_each do |article|
      if article.published_at < Time.now
        article.set_published_state.save
      end
    end
  end
end
