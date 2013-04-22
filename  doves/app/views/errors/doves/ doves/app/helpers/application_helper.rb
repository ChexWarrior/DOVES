module ApplicationHelper

def page_title
  (@content_for_title + " &mdash; " if @content_for_title).to_s
end

def page_heading(text)
  content_tag(:h1, content_for(:title){ text })
end

def results_per_page
	[
      ['10', 10],
      ['25', 25],
      ['50', 50],
    ]
end

end
