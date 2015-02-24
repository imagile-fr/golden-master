require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :approve, [:page] do |t, args|
  args.with_defaults(:page => "*")
  if args.page == "*"
    sh "cp .lockdown/received/*.html .lockdown/approved/"
  else
    sh "cp .lockdown/received/#{args.page}.html .lockdown/approved/#{args.page}.html"
  end
end
