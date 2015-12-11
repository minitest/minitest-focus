class Minitest::Test    # :nodoc:
  class Focus           # :nodoc:
    VERSION = "1.1.2"   # :nodoc:
  end

  @@filtered_names = [] # :nodoc:

  def self.add_to_filter name
    @@filtered_names << "#{self}##{name}"
    filter = "/^(#{Regexp.union(@@filtered_names).source})$/"

    index = ARGV.index("-n")

    if index then
      warn "NOTE: Found `-n <regexp>` arg. This breaks under Rake::TestTask"
    end

    index = ARGV.index { |arg| arg =~ /^-n/ }
    ARGV.delete_at index if index

    ARGV << "-n=#{filter}"
  end

  ##
  # Focus on the next test defined. Cumulative. Equivalent to
  # running with command line arg: -n /test_name|.../
  #
  #   class MyTest < MiniTest::Unit::TestCase
  #     ...
  #     focus
  #     def test_pass; ... end # this one will run
  #     ...
  #   end

  def self.focus
    meta = class << self; self; end

    meta.send :define_method, :method_added do |name|
      add_to_filter name

      meta.send :remove_method, :method_added
    end
  end
end
