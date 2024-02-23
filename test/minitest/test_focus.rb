require "minitest/autorun"
require "minitest/focus"

class MyTest1 < Minitest::Test
         def test_fail;            flunk; end
  focus; def test_method;          pass;  end
  focus  def test_method2;         pass;  end
         focus \
         def test_method3;         pass;  end
         def test_method_edgecase; flunk; end
end

describe "MyTest2" do
         it "is ignored"            do flunk end
  focus; it "does something"        do pass  end
  focus  it("does something else")  { pass } # stupid block precedence needs {}
         it "bombs"                 do flunk end
  focus; it "has non-word ['chars'" do pass  end # Will raise invalid RegExp unless correctly escaped
end

describe "MyTest3" do
         describe("Nope")    {                        it "nope"       do flunk end }
  focus  describe("Inline")  {                        it "inline"     do pass  end
                               describe("Inline^2") { it "inline^2"   do pass  end } }
         describe("Middle")  {                        it "middle"     do flunk end }
  focus; describe("Next")    {                        it "next"       do pass  end
                               describe("Next^2")   { it "next^2"     do pass  end } }
         describe("Trail")   {                        it "trail"      do flunk end }
  focus; describe("Empty")   {};                      it "post empty" do flunk end
end
