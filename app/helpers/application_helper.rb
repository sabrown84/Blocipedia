module ApplicationHelper

  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, exentsions)
    (redcarpet.render markdown).html_safe
  end
  
end
