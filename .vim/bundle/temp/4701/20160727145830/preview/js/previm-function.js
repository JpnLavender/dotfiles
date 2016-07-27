function isShowHeader() {
return 1;
}

function getFileName() {
return "/Users/roof/Desktop/AllFile/Programming/Hibiscus/README.md";
}

function getFileType() {
return "markdown";
}

function getLastModified() {
return "2016/07/25 (月) 10:11:38";
}

function getContent() {
return "#Hibiscus\n\n##Features\nTwitterに指定した時間の間隔で、登録した単語をランダムで3回投稿してくれるTwitterBot\n設定によっては、Slackとの連携も可能。\n\n####Default\n・1分に1回投稿\n\n##Requirement\nRuby 2.3.0  \ngem 2.5.1  \nbundle 1.12.5\n\n###SlackCooperationFunctional\n1. Slack投稿確認\n\n##Structrue\nBot<--->API(AdminPage)<--->DataBase\n\n###FunctionalExplain\n\n1. Bot  \n純粋なRubyで作していて、botはただTweetを投稿するだけで、常にloopしている\n\n2. API(管理ページ)\nSinatraで動作していて、Webページから単語の登録や管理、APIの提供をしている\n\n3. DataBase  \nAPIで登録された単語を保存する\n\n##Response Json Data\n\n###json \n\n```json\n{\n  \"data\": {\n    \"id\": \"stock_data.id\",\n    \"message\": \"stock_data.message\",\n    \"url\": \"stock_data.url\",\n    \"img_url\": \"stock_data.img_url\",\n    \"count\": \"stock_data.count \"\n  },\n  \"status\": {\n    \"id\": \"status.number\"\n  }\n}\n```\n\n**id**: DBにストックされてるデータの連番   \n**message**: ストックされてるidに関連付けされてる一言メッセージ  \n**url**: ストックされてるidに関連付けされてるurl用のデータ  \n**img_url**: ストックされてるidに関連付けされてるimage用のデータ  \n**count**: 今まで何回同じものが投稿されたかのカウント  \n**status**: エラーなどのステータス  \n\n##status id\n**0**: 異常なし  \n\n**404**: Stockデータが無いか、一時的エラーでデータが見つからなかった\n\n##Usage\n\n###local(install & ProgramRun )\n\nTwitterのAPIキーなどは、環境変数で扱うのでまず、環境変数の設定をしましょう！\n**(環境変数を使う場合は変数名と値の'='の間にスペースは入れないでくださいまた、ダブルクオーテーションなどで囲むひつようもありません)**\n\n```bash\n$ export CONSUMER_KEY=コンシューマーキー\n$ export CONSUMER_SECRET=コンシューマーシークレットキー\n$ export ACCESS_TOKEN=アクセストークンキー\n$ export ACCESS_TOKEN_SECRET=アクセスシークレットキー\n$ export WEBHOOKS=SlackのWEBHooksURL\n```\n\n環境変数の設定が終わったら、HibiscusのDownload＆設定をしましょう!\n\n```bash\n$ git clone https://github.com/JpnLavender/Hibiscus\n\n$ cd Hibiscus/\n\n$ bundle install \n\n$ bundle exec rake db:migrate\n\n$ ruby app.rb\n\n#new tab or Pain↓\n\n$ cd bot/\n\n$ ruby config.rb\n```\n\n###ShowWebPage\n\nWebページを開いて、検索欄に**localhost:4567**or**127.0.0.1:4567**と入力  \n<!-- ![LoginPage](file://localhost/Users/roof/Desktop/AllFile/Programming/Hibiscus//readme/login-page.png) -->\nページが表示されたら、CreateAccountを選択  \nそこで、ページが表示されたら、アカウント登録してください    \n**(現時点では、アカウント登録が完了しても、権限がないためログインすることができません。なので、ログインの権限を付与してあげます)**\n\n<!-- ![SiginupPage](file://localhost/Users/roof/Desktop/AllFile/Programming/Hibiscus//readme/siginup-page.png) -->\n\nアカウント登録が終わったら、shellで**irb**を入力\n\n```bash\n$ irb\n```\npryが開いたら、以下にそって権限を付与してあげましょう\n```ruby\nirb(main)> require './app'\nirb(main)> User.last.update(administrator: true)\n#=>true\nirb(main)> exit\n```\n\n**[2]**を打ったあと、**true**と返ってきたら、成功です！  \nWebページに戻り、Loginができるようになったら成功です！  \nLoginしたあと、SettingPageを開いて、Twitter用のAccessTokenなどを登録すればして  \n管理ページに入り、好きな単語を登録すれば、自動的に、投稿してくれるはずです  ";
}
