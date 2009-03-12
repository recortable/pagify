ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :users
    admin.resources :attachments
    admin.resources :pages do |pages|
      pages.resources :contents
      pages.resources :metas
      pages.resources :attachments
    end
    admin.resources :site
  end

  map.connect 'admin/system/:action', :controller => 'admin/system'
  map.connect 'admin/pages/:action/:id', :controller => 'admin/pages'
  map.connect 'admin/attachments/:action/:id', :controller => 'admin/attachments'
end