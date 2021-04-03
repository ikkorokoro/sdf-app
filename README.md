# SDF-Review
自衛隊で使用するアイテムのレビューを投稿し、自衛官がより優秀なアイテムを見つけるアプリです。

以下アプリのリンクになります

URL https://sdf-app-portforio.com

# 開発背景
自衛隊に勤務している中で感じていた、3つの課題を解決できるものを作りたいと思ったことがこのアプリを作るきっかけとなりました。

まず1点目は

* 自衛官は装備、装具を購入の出費が多いこと。

2点目は

* 訓練や演習でよりパフォーマンスを上げるためにはより優れた装具、装備を身につける必要があること。

3点目は

* 自衛隊の使用している物品は多種多様であり、また用途は同じ物でも購入する場所、メーカーによって機能面、耐久面、金銭面でも大きく変わってくる。
だがその情報が少ないため、使い勝手の悪い、欠点の多い物を購入してしまい買い直すことが多々ある。

これらを解決させて、よりコスパの良いアイテムを購入して自衛官のパフォーマンスを向上に繋げられるアプリを作りたいと思い作成しました。


# 工夫点
機能面で工夫した点は2つあります。

1点目が
* 購入したアイテムをレビューするだけではなく、楽天APIを用いて購入までの導線を引くようにしました。

  当初はユーザーが購入したアイテムをレビューを投稿できるという機能のみでしたが、購入まで繋げられるとアプリの本質でもある、自衛官がより優秀なアイテムを手にすることができるという利点があるため導入しました。
また、APIで取得した商品は特に自衛官が御用達であり、実用的なアイテムが揃っている「戦人」のアイテムのみを取り扱うようにしました

2点目は
* タグ機能をつけ、アイテムの利用シーンがわかるようにしました。

  タグ機能を導入することでユーザーが投稿を見た時にどこで使えるアイテムなのか、どの時期で使えるアイテムかなどをわかりやすくし、またタグで検索できるようにすることでユーザー  が求めているアイテムをよりマッチしやすいようにしました。

# 機能一覧 
  * ユーザー登録/ログイン(devise)
  * ゲストログイン 
  * 投稿機能(CRUD)
  * コメント機能(Ajax)
  * ユーザ管理機能
    * プロフィール編集機能(actiontext)
    * 投稿表示機能
    * いいねした投稿表示機能
    * フォローしたユーザーの投稿表示機能
    * フォロー、フォロワーのユーザー一覧機能
  * 画像アップロード機能
  * ページネーション
  * いいね機能(ajax)
  * フォロー機能(ajax)
  * いいねランキング機能
  * 星評価機能
  * 検索機能
  * カテゴリ機能
  * タグ機能
  * ソート機能
  * 通知機能
  * 楽天API
  * N+1問題解消
  * レスポンシブ対応
# 使用技術一覧
* フロントエンド 
  * HAML
  * SCSS 
  * JavaScript 
  * jQuery
  * Bootstrap
* バックエンド 
  * Ruby 2.6.5
  * Ruby on Rails 6.0.3
  * MySQL
  * Webサーバー　Nginx
  * アプリケーションサーバー puma
* テスト
  * RSpec
* 自動デプロイ
  * Capistrano
* インフラ 
  * AWS(VPC/EC2/RDS/ALB/S3/ACM/Route53)
  * docker
  * docker-comporce
* バージョン管理  
  * Git/GitHub 
# データベース設計
![drow io](https://user-images.githubusercontent.com/62924821/113077697-9743d500-920c-11eb-8b47-1cba48c8c6ed.png)


