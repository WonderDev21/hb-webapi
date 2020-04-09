require 'rails_helper'
require 'markdown_renderer'

RSpec.describe MarkdownRenderer, type: :model do
  describe '#render' do
    let(:renderer) { MarkdownRenderer.new }

    {
      '# Header' => "<h1>Header</h1>\n",
      '**bold text**' => "<p><strong>bold text</strong></p>\n",
      '*italicized text*' => "<p><em>italicized text</em></p>\n",
      "  1. first item\n  2. second item" => "<ol>\n<li>first item</li>\n<li>second item</li>\n</ol>\n",
      "  - first item\n  - second item" => "<ul>\n<li>first item</li>\n<li>second item</li>\n</ul>\n",
      '[inline link](https://www.google.com)' => "<p>[inline link](https://www.google.com)</p>\n",
      '![alt text](https://google.com/image.png)' => "<p>![alt text](https://google.com/image.png)</p>\n",
      '<dl><dt>hello</dt><dd>world</dd></dl>' => "<p>helloworld</p>\n"
    }.each do |markdown, expected_output|
      it "render Markdown text as HTML: #{markdown}" do
        expect(renderer.render(markdown)).to eq(expected_output)
      end
    end
  end
end
