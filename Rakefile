require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require_relative './lib/metamatter'

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ["--order", "rand", "--color"]
end