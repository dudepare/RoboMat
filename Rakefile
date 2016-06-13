require 'rake/testtask'

Rake::TestTask.new do |task|
  task.libs << %w(lib spec)
  task.pattern = 'spec/*_test.rb'
end

task :default => :test
