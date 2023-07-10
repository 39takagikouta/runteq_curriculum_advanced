namespace :article_summary do
  desc 'am9時に公開済記事の集計結果を管理者にメールで送る'
  task mail_article_summary: :environment do
    ArticleMailer.report_summary.deliver_now
  end
end
