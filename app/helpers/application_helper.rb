# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def list_pages(pages)
    html = ''
    html += '<ul id="subpage_list_' + pages.first.parent_id.to_s + '"'
    pages.each do |page|
      html += '<li class="subpage" id="subpage_' + page.id.to_s + '"><div>'
      html += link_to page.name, {:controller => 'subpage', :action => 'edit', :id => page.id}, :class => "label"
      html += '<span>' + link_to(image_tag("/images/admin/remove.png"), {:controller => 'subpage', :action => 'delete', :id => page.id}, :confirm => "Jesteś pewien, że chcesz usunąć tę stronę?")
      html += '</span></div></li>'
    end
    html += '</ul>'
    html
  end
end
