require 'rails_helper'

RSpec.describe 'Like', type: :system do
let!(:user) {create(:user)}
let!(:other_user) {create(:user)}
let!(:article) {create(:article, user: other_user)}

  describe 'いいねの検証' do
    context 'いいねしていない場合' do
      it 'いいねできる' do
        sign_in user
        visit root_path
        show_link = first('#show-link')
        show_link.click
        expect(page).to have_css('#notgood')
        expect(find('#notgood').click).to change{Like.count}.by(1)
      end
    end
  end
end
