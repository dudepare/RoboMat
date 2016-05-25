require 'rake/testtask'

Rake::TestTask.new do |task|
  task.libs << %w(tests)
  task.pattern = 'tests/*_test.rb'
end

task :default => :test
