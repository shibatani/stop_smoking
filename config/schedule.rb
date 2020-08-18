
# 絶対パスから相対パス指定
env :PATH, ENV['PATH']
# ログファイルの出力先
set :output, 'log/cron.log'
# ジョブの実行環境の指定
set :environment, :development

every 1.minutes do
# Rails内のメソッド実行
  runner "LoginMailer.send_when_not_login", output: { error: "log/cron.log" }
end

