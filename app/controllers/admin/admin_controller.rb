
class Admin::AdminController < ActionController::Base

  PAGES_VERSION = "0.4.020"

  layout 'admin'
  before_filter :authenticate_admin
  before_filter :load_site
  helper :admin

  private
  def authenticate_admin
    authenticate_or_request_with_http_basic('Pages::Admin') do |name, pass|
      # #User.authenticate(name, pass)
      user_valid(name, pass) || admin_valid(name, pass)
    end
  end

  def load_site
    @site = Page.find(1)
  end

  def user_valid(name, pass)
    session[:admin] = false
    name == APP_CONFIG['user']['name'] && pass == APP_CONFIG['user']['pass']
  end

  def admin_valid(name, pass)
    admin = APP_CONFIG['admin']

    if !admin.nil? && name == admin['name'] && pass == admin['pass']
      session[:admin] = true
      true
    elsif
      false
    end
  end
end
