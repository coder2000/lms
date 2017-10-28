# Application controller
#  Base for all controllers
class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :require_login, :set_locale, :set_paper_trail_whodunnit, :load_conversations

  responders :flash

  def self.default_url_options
    { locale: I18n.locale }
  end

  def not_authenticated
    redirect_to login_path
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def load_conversations
    @chats = Conversation.participating(current_user).order('updated_at DESC') if current_user
  end
end
