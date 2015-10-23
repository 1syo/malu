require './app'
require 'rake/testtask'
load 'tasks/route.rake'

Rake::TestTask.new do |t|
  t.libs.push 'spec'
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

task default: :test
