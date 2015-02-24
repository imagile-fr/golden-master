# encoding: utf-8

require 'spec_helper.rb'

describe "Blog", type: :feature do
  it "shows all the articles on home page" do
    visit '/'
    page_html_should_be_identical_to_approved('home')
  end

  it "shows an article" do
    visit '/posts/display/1'
    page_html_should_be_identical_to_approved('post')
  end
end
