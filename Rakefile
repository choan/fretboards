require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end


desc "Run tests"
task :default => :test

task :build do
  sh "gem build fretboards.gemspec"
end