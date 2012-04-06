require 'bundler'
require 'rspec/core/rake_task'
Bundler::GemHelper.install_tasks

task :default => [:test]

RSpec::Core::RakeTask.new('test') do |s|
  s.rspec_opts = '-c'
end

