require 'rails_helper'

RSpec.describe 'Article', type: :system do
  let!(:user) {create(:user, email: 'test@example.com')}
  let!(:article) {create(:article, user: user)}
  let!(:tag){create(:tag)}

  it '記事一覧を表示する' do
    visit root_path
      expect(page).to have_content(article.object)
    end

  describe '新しい記事を作成,編集、削除する' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '記事を投稿できる' do
        visit root_path
        click_link '投稿'
        expect {
        attach_file('article_image', 'app/assets/images/danntaio-01.jpg', make_visible: true)
        fill_in '物品名', with: '戦闘服'
        fill_in '購入金額', with: 2000
        fill_in '購入場所', with: '遠軽駐屯地'
        choose('鉄帽')
        check('訓練')
        #visible: dalseをfindメソッドに付けると、hidden_fieldも探せる
        find('#review_star', visible: false).set(5)
        fill_in '感想', with: '良い商品'
        click_button '保存する'
        }.to change{Article.count}.by(1)
        expect(page).to have_text('保存できました')
      end

      it '記事を編集,更新できる' do
        visit edit_article_path(article)
        attach_file('article_image', 'app/assets/images/C704-01.jpg', make_visible: true)
        fill_in '物品名', with: '鉄帽'
        fill_in '購入金額', with: 3000
        fill_in '購入場所', with: '北海道駐屯地'
        choose('鉄帽')
        check('訓練')
        #visible: dalseをfindメソッドに付けると、hidden_fieldも探せる
        find('#review_star', visible: false).set(5)
        fill_in '感想', with: '悪い商品'
        click_button '保存する'
        expect(page).to have_text('更新に成功しました')
      end
    end
  end
end
      # it '記事を削除できる' do
      #   visit edit_article_path(article)
      #   expect{
      #     click_link '削除'
      #     #ダイアログok選択
      #     page.accept_confirm do
      #       click_on :delete_button
      #     end
      #   }.to change{Article.count}.by(-1)
      # end
      # scenario '秘密の隠しボタンをクリックする', js: true do
      #   visit secret_path
      #   find('.secret-area').hover
      #   # hover中しか表示されないボタンをクリックする
      #   find('.secret-button').click
      # end
