# -*- encoding: utf-8 -*-
require 'spec_helper'

describe "The set entries view", js: true do
  before do
    home, @page = StandardTree.build_minimal_with_slices
    sign_in_as_admin
    set_page, articles = StandardTree.add_article_set(@page)
    51.times { StandardTree.add_article(set_page) }
    visit admin_page_entries_path page_id: set_page.id
  end

  it "displays the correct number on the first page" do
    page.should have_css 'tbody tr', count: 50
  end

  it "displays the correct number on the second page" do
    jqtrigger '#pagination li:last-child a', :click
    page.should have_css 'tbody tr', count: 3
  end

  it "links to the page editor" do
    article = Article.all.second
    click_on article.name

    page.should have_css '#meta-name' # Stop next spec randomly failing
    page.should have_field 'Page Name', with: article.name
  end
end

describe "Deleting an article from the entries view", js: true do
  it "works as expected" do
    home, normal_page = StandardTree.build_minimal_with_slices
    sign_in_as_admin
    set_page, articles = StandardTree.add_article_set normal_page
    set_page.children.first.destroy

    visit admin_page_entries_path set_page
    page.should have_css 'tbody tr', count: 1

    within('tbody tr:first-child') { click_on 'Delete' }

    page.should have_no_css 'tbody tr'
    page.should have_stopped_communicating
    Article.count.should == 0
  end
end

describe "When sort_field is set to :position", js: true do
  it "displays entries in order of position" do
    home, parent = StandardTree.build_minimal_with_slices
    set_page, articles = StandardTree.add_article_set parent
    Article.destroy_all

    set_slice = set_page.sets.first
    set_slice.sort_direction = 'asc'
    set_slice.sort_field = 'position'
    set_slice.save!

    first_entry = Article.make(
      parent: set_page,
      name: 'ZZZ',
      position: 0
    )
    second_entry = Article.make(
      parent: set_page,
      name: 'AAA',
      position: 1
    )
    thrid_entry = Article.make(
      parent: set_page,
      name: '111',
      position: 2
    )

    sign_in_as_admin
    visit admin_page_entries_path page_id: set_page.id

    page.all('tbody .name a').map(&:text).should == %w[ZZZ AAA 111]
  end
end
