require 'spec_helper'

describe "Deleting a page", js: true do

  before do
    home, @page = StandardTree.build_minimal
    sign_in_as_admin
    visit "/admin/site_maps"
  end

  context "when unlocking the site map" do
    before do
      click_on 'Unlock structure?'
    end

    it "displays the page in the site map" do
      page.should have_css("li[rel='#{@page.id}']", text: 'Parent')
    end

    context "deleting the page" do
      before do
        auto_confirm_with true
        js_click_on "li[rel=#{@page.id}] a.delete"
      end

      it "removes the page from the tree" do
        page.should_not have_content 'Parent'
        page.should_not have_css "li[rel='#{@page.id}']", text: 'Parent'
      end
    end
  end
end
