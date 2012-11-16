module Test
  require File.expand_path(File.dirname(__FILE__)) + '/../lib/gharial'
  require "test/unit"

  class TestIssues < Test::Unit::TestCase
    def test_all
      issues = Gharial::Issues.all

      assert_equal(3, issues.count)
      assert_equal("i'm 12 what is this", issues.first.title )
    end
  end
end
