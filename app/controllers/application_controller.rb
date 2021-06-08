class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :all_categorys_and_tags
  before_action :set_q
  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:account])
  end

  def all_categorys_and_tags
    if user_signed_in?
      @categorys = Category.all
      @tags = Tag.all
    end
  end

  def set_q
    @q = Article.with_attached_image.includes(:tags, user: [profile: [avatar_attachment: :blob]]).ransack(params[:q])
  end
end
