require 'bundler/gem_tasks'
require 'yard'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:test)

YARD::Rake::YardocTask.new do |t|
  t.name = 'doc'
end

desc 'cleanup working copy'
task :clean do
  FileUtils.rm_rf %w(Gemfile.lock coverage doc pkg)
end

task :default do
  system "rake -T"
end
