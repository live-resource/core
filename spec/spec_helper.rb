$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

def require_tree(path)
  path = File.expand_path(path, File.dirname(__FILE__))

  files = Dir.glob(File.join(path, '**/*.rb'))
  raise "Directory '#{path}' is empty" unless files.length > 0

  files.each { |file| puts "  require #{file}"; require file }
end

require_tree '../lib'
require_tree 'support'
require 'live_resource/rspec'

module DescribeHelpers
  def expect_its(*args, &block)
    its(*args, &block)
  end
end

RSpec.configure do |config|
  config.include LiveResource::RSpec

  # Alias the existing one-liner syntax to #expect_it, so that lines like the following will work:
  #   expect_it { to be(:something) }
  config.alias_example_to :expect_it
  config.extend(DescribeHelpers)
end

RSpec::Core::ExampleGroup.module_eval do
  alias to should
  alias to_not should_not
end
