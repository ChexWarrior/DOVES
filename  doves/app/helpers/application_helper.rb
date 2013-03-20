module ApplicationHelper

def page_title
  (@content_for_title + " &mdash; " if @content_for_title).to_s
end

def page_heading(text)
  content_tag(:h1, content_for(:title){ text })
end


end
