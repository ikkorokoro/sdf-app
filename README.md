# SDF-APP
自衛隊で使用するアイテムのレビューを投稿し、自衛官がより優秀なアイテムを見つけるアプリです。
#概要
私は前職、自衛隊に勤務しており、その中で以下を課題と感じました。
１、自衛官は装備、装具を購入の出費が多い。
２、訓練や演習でよりパフォーマンスを上げるためにはより優れた装具、装備を身につける必要がある。
３、自衛隊の使用している物品は多種多様であり、また用途は同じ物でも購入する場所、メーカーによって機能面、耐久面、金銭面でも大きく変わってくる。だがその情報が少ないため、使い勝手の悪い、欠点の多い物を購入してしまい買い直すことが多々ある。
これらの課題を解決するため、購入したアイテムのレビューを投稿するアプリをを開発しようと考えました。

# 機能一覧 
  ・ユーザー登録/ログイン(devise)
  
  ・ゲストログイン 
  ・投稿機能(CRUD)
  ・コメント機能(Ajax)
  ・ユーザ管理機能
    ○プロフィール編集機能
      ・affiliationカラム(actiontext)
    ○投稿表示機能
    ○いいねした投稿表示機能
    ○フォローしたユーザーの投稿表示機能
    ○フォロー、フォロワーのユーザー一覧機能
  ・画像アップロード機能
  ・いいね機能(ajax)
  ・フォロー機能(ajax)
  ・いいねランキング機能 
  ・ページネーション (kaminari)
  ・検索機能
  ・カテゴリ機能
  ・タグ機能
  ・ソート機能
  ・通知機能

# 使用技術一覧
  ◇フロントエンド 
  ・HAML
  ・SCSS 
  ・JavaScript 
  ・jQuery
  ・Bootstrap
 ◇バックエンド 
  ・Ruby 2.6.5 
  ・Ruby on Rails 6.0.3
  ・MySQL
  ・Webサーバー　Nginx
  ・アプリケーションサーバー puma
  ・Capistrano
 ◇テスト 
  ・RSpec
 ◇インフラ 
  ・AWS(VPC/EC2/RDS/ALB/S3/ACM/Route53)
 ◇バージョン管理  
  ・Git/GitHub 
