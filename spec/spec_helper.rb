# encoding: utf-8

require 'capybara/poltergeist'
require 'capybara/rspec'
Capybara.javascript_driver = Capybara.default_driver = :poltergeist
Capybara.app_host = 'http://localhost'

FileUtils.mkdir_p('.lockdown/received')
FileUtils.mkdir_p('.lockdown/approved')

def page_html_should_be_identical_to_approved(page_name)
  File.open(".lockdown/received/#{page_name}.html", 'w') do |f|
    f.puts page.html
  end
  approved = File.read(".lockdown/approved/#{page_name}.html")
  expect(page.html.strip).to eq approved.strip
end
