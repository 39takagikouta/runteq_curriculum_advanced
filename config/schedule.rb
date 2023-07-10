require File.expand_path(File.dirname(__FILE__) + '/environment')
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"





every :hour do
  rake 'article_state:update_article_state'
end

every 1.day, at: '9am' do
  rake 'article_summary:mail_article_summary'
end
