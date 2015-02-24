# encoding: utf-8

require 'spec_helper.rb'

describe "Blog", type: :feature do
  it "shows all the articles on home page" do
    visit '/'
    page_html_should_be_identical_to_approved('home')
  end
end
