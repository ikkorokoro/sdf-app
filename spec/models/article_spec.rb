# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  content     :string(191)      not null
#  object      :string(191)      not null
#  price       :integer          not null
#  rate        :integer
#  store       :string(191)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_articles_on_category_id  (category_id)
#  index_articles_on_user_id      (user_id)
#
require 'rails_helper'
RSpec.describe 'Article', type: :model do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }

  context '全てのカラムが入力されている場合' do
    let!(:article) { build(:article, user: user, category: category ) }

    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end

  context 'objectが入力されていない場合' do
    let!(:article) { build(:article, object: '', user: user, category: category) }

    before do
      article.save
    end

    it '記事は保存できない' do
      expect(article.errors.messages[:object][0]).to eq('を入力してください')
    end
  end

  context 'priceが入力されていない場合' do
    let!(:article) { build(:article, price: '', user: user, category: category) }

    before do
      article.save
    end

    it '記事は保存できない' do
      expect(article.errors.messages[:price][0]).to eq('を入力してください')
    end
  end

  context 'rateが入力されていない場合' do
    let!(:article) { build(:article, rate: '', user: user, category: category) }

    before do
      article.save
    end

    it '記事は保存できない' do
      expect(article.errors.messages[:rate][0]).to eq('を入力してください')
    end
  end

  context 'contentが入力されていない場合' do
    let!(:article) { build(:article, content: '', user: user, category: category) }

    before do
      article.save
    end

    it '記事は保存できない' do
      expect(article.errors.messages[:content][0]).to eq('を入力してください')
    end
  end

  context 'contentが100文字以上の場合' do
    let!(:article) { build(:article, content: 'あ' * 101 , user: user, category: category)}

    before do
      article.save
    end

    it '記事は保存されない' do
      expect(article.errors.messages[:content][0]).to eq('は100文字以内で入力してください')
    end
  end
  describe '削除の検証' do
    context '記事が削除された場合' do
      let!(:other_user) { create(:user) }
      let!(:article) { build(:article, user: user, category: category ) }
      let!(:comment) { create(:comment, user: user, article: article) }
      let!(:like) { create(:like, user: user, article: article) }
      let!(:tag) { create(:tag) }
      let!(:article_tag) {create(:article_tag, article: article, tag: tag)}
      let!(:notification) { create(:notification, article_id: article.id, visited_id: user.id, visiter_id: other_user.id)}
      it '正常に削除される' do
        expect{article.destroy}.to change{Article.count}.by(-1)
      end
      it '紐ずくコメントも削除される' do
        expect{article.destroy}.to change{article.comments.count}.by(-1)
      end
      it '紐ずくいいねも削除される' do
        expect{article.destroy}.to change{article.likes.count}.by(-1)
      end
      it '紐ずくarticle_tagも削除される' do
        expect{article.destroy}.to change{article.article_tags.count}.by(-1)
      end
      it '紐ずく通知も削除される' do
        expect{article.destroy}.to change{article.notifications.count}.by(-1)
      end
    end
  end
end
