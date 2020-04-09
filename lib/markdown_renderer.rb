require 'redcarpet'

class MarkdownRenderer
  MARKDOWN_OPTIONS = {
    tables: false,
    fenced_code_blocks: false,
    autolink: false,
    strikethrough: true
  }.freeze

  HTML_OPTIONS = {
    filter_html: true,
    no_images: true,
    no_links: true,
    no_styles: true,
    with_toc_data: false,
    hard_wrap: true
  }.freeze

  def initialize
    html_renderer = Redcarpet::Render::HTML.new(HTML_OPTIONS)
    @renderer = Redcarpet::Markdown.new(html_renderer, MARKDOWN_OPTIONS)
  end

  def render(markdown)
    @renderer.render(markdown)
  end
end
