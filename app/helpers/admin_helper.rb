require 'RedCloth'

module AdminHelper
  include ActionView::Helpers::TagHelper


  def redcloth(text)
    removed = text.gsub(/"target=blank/, '')
    rc = RedCloth.new(removed)
    rc.hard_breaks = false
    rc.to_html
  end

  def render_page(page)
    r = $PAGE_RENDERERS[page.mime]
    return r.call(page.content) unless r.nil?
    return page.content
  end

  def render_agenda(page)
    content_tag(:div, :class=>'item agenda') do
      content_tag(:div, page.first_line, :class=> 'date') +
        content_tag(:div, page.title, :class => 'title') +
        content_tag(:div, page.skip_first_line, :class => 'content')
    end
  end

  $PAGE_RENDERERS = {}
  $PAGE_RENDERERS['agenda'] = lambda {|p| render_agenda(p)}


  def clear
    '<div class="spacer">&nbsp;</div>'
  end

  def fecha(date)
    date.strftime('%d/%m/%Y')
  end

  def action(image, text, path)
    img = image.nil? ? '' : image_tag("admin/#{image}")
    '<div class="action">' + link_to("#{img}<span>&nbsp;#{text}</span>", path) + '</div>'
  end

  def javascript_action(image, text, javascript)
    img = image.nil? ? '' : image_tag(image)
    '<div class="action"><a href="#" onClick="javascript:' + javascript + '">' + img + '&nbsp;' + text + '</a></div>';
  end

  def submit_button(label, javascript)
    '<div class="spacer"><a href="#" onClick="javascript:' + javascript + '" class="green">' + label + '</a></div>'
  end

  def action_area(&block)
    concat('<div class="actions">', block.binding)
    yield
    concat( '</div><div class="spacer">&nbsp;</div><br/>', block.binding )
  end

  def btn_tag(file, label)
    image_tag(file) + " #{label}"
  end

  def tabs
    result = '<div class="tabs">'
    result << yield
    result <<  '</div><div class="spacer">&nbsp;</div><br/>'
  end

  def admin?
    session[:admin] == true
  end
  
  def  can_add_children(depth, addeable)
    return true if addeable == :all
    return false if addeable == :none
    # TODO: falta aplicar a rangos
    return addeable == depth
  end
  
  def link_to_edit_page(page)
    return link_to(page.title, edit_admin_page_path(page)) # unless page.locked?
    # #return link_to(page.title, {:action => 'meta', :id => page}) if
    # page.locked?
  end

  def icon(name, label, visible = false)
    result = image_tag("admin/icons/#{name.to_s}.png", :alt => label)
    result << "&nbsp;#{label}" if visible
    return result
  end
  
  
  def tab(name, path, current)
    current == name ? "<div class=\"active\">#{name}</div>" : link_to( name, path) 
  end
  
  def page_tabs(page, current)
    tabs do
      tab('Páginas', admin_pages_path, current) <<
        tab('Editar', edit_admin_page_path(page), current)
    end
  end
  
  def project_tabs(current)
    tabs do
      tab('Páginas', admin_pages_path, current) <<
        (session[:admin] ? tab('Archivos e imágenes', admin_attachments_path, current) <<
          tab('Info', {:controller => '/admin/system', :action => 'info'}, current) : '')
    end
  end
  
end
