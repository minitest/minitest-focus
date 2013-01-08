require "minitest/autorun"
require "minitest/focus"

class MyTest < MiniTest::Unit::TestCase
         def test_fail;            flunk; end
  focus; def test_method;          pass;  end
         def test_method_edgecase; flunk; end
end

describe MyTest do
         it "is ignored"     do flunk end
  focus; it "does something" do pass  end
         it "bombs"          do flunk end
end
