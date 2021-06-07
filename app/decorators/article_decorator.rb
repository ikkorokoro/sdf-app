# frozen_string_literal: true

module ArticleDecorator
  def cat_name
    category.category_name
  end

  def comment_count
    comments.count
  end

  def like_count
    likes.count
  end

  def author_image
    user.avatar_image
  end

  def author_name
    user.display_name
  end
end
