require 'bundler/gem_tasks'
require 'rake/testtask'
require 'yard/rake/yardoc_task'

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.libs.push "spec"
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = false
end

YARD::Rake::YardocTask.new do |t|
  t.name = 'doc'
end

desc 'cleanup working copy'
task :clean do
  FileUtils.rm_rf('coverage')
  FileUtils.rm_rf('doc')
end
