require "spec_helper"

describe "Slices::CmsFormBuilder" do

  def snowman
    txt =  %{<div style="margin:0;padding:0;display:inline">}
    txt << %{<input name="utf8" type="hidden" value="&#x2713;" />}
    txt << %{</div>}
  end

  def form_text(action = "/", id = nil, html_class = nil)
    txt =  %{<form accept-charset="UTF-8" action="#{action}"}
    txt << %{ class="#{html_class}"} if html_class
    txt << %{ id="#{id}"} if id
    txt << %{ method="post">}
  end

  def whole_form(action = "/", id = nil, html_class = nil)
    contents = block_given? ? yield : ""
    form_text(action, id, html_class) + snowman + contents + "</form>"
  end

  let :page do
    Page.new
  end

  context "#cms_text_field" do
    let :form do
      helper.form_for page, builder: Slices::CmsFormBuilder, url: '/' do |form|
        form.cms_text_field :name
      end
    end

    it "renders the field" do
      expected = whole_form '/', 'new_page', 'new_page' do
        '<li>' +
          '<label for="page_name">Name</label>' +
          '<input id="page_name" name="page[name]" size="30" type="text" />' +
        '</li>'
      end

      assert_dom_equal expected, form
    end

    it "renders the field with errors" do
      page.valid?

      expected = whole_form '/', 'new_page', 'new_page' do
        '<li class="error">' +
          '<label for="page_name">Name</label>' +
          '<input id="page_name" name="page[name]" size="30" type="text" />' +
          '<p>can&#x27;t be blank</p>' +
        '</li>'
      end

      assert_dom_equal expected, form
    end

  end
end
