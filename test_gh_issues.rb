require "./gh_issues"
require "test/unit"

class TestGhIssues < Test::Unit::TestCase
  def test_all
    subject = GhIssues.all
    assert_equal(2, subject.count)
    assert_equal("There's a bug here", subject[0]["title"] )
  end
end
