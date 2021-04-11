require 'rails_helper'

RSpec.describe 'User', type: :system do
  let!(:user) {create(:user, email: 'test@example.com')}
  let!(:articles) {create_list(:article, 3, user: user)}
  context '新規登録、ログインしていない場合' do
    it '新規登録できる' do
      visit root_path
      click_link '新規登録'
      expect {
        fill_in 'アカウント名', with: 'alice'
        fill_in 'メールアドレス', with: 'alice@email.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button '新規登録'
      }.to change{User.count}.by(1)
      expect(page).to have_content('アカウント登録が完了しました')
    end

    it 'ログインできる' do
      visit root_path
      click_link 'ログイン'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      expect(page).to have_text('ログインしました。')
    end
  end
  context 'ログインしている場合' do
    it 'ログアウトできる' do
      visit root_path
      find('hoverdown').hover
      find('hoverdown-content').first('a').click
      expect(page).to have_text('ログアウトしました。')
    end
  end
end