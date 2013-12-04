class Minitest::Test    # :nodoc:
  class Focus           # :nodoc:
    VERSION = "1.1.0"   # :nodoc:
  end

  @@filtered_names = [] # :nodoc:

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
      @@filtered_names << "#{self}##{name}"
      filter = "/^(#{@@filtered_names.map { |f| Regexp.escape f }.join "|"})$/"

      index = ARGV.index("-n")
      unless index then
        index = ARGV.size
        ARGV << "-n"
      end

      ARGV[index + 1] = filter

      meta.send :remove_method, :method_added
    end
  end
end
