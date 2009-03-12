
class PageSweeper < ActionController::Caching::Sweeper
  observe Page

  def after_create(page)
    expire_cache_for(page)
  end

  def after_update(page)
    expire_cache_for(page)
  end

  def after_destroy(page)
    expire_cache_for(page)
  end

  private
  def expire_cache_for(page)
    puts "Page changed: " + page.title
    # Expire the list page now that we pageed a new blog entry
    expire_page(:controller => '/xy/calcaxy')
  end
end
