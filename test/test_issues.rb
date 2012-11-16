module Test
  require File.expand_path(File.dirname(__FILE__)) + '/../lib/gharial'
  require "test/unit"

  class TestIssues < Test::Unit::TestCase
    def test_all
      issues = Gharial::Issues.all

      assert_equal(3, issues.count)
      assert_equal("i'm 12 what is this", issues.first.title )
      (1..1000000).each{|a| a+1}
    end

    def test_labels
      issues = Gharial::Issues.labels(['bug', 'duplicate']).execute

      assert_equal(1, issues.count)
      assert_equal("There's a bug here", issues.first.title )
      (1..1000000).each{|a| a+1}
    end

    def test_creator
      issues = Gharial::Issues.creator('marcheb').execute

      assert_equal(2, issues.count)
      assert_equal("There's a bug here", issues.first.title )
      (1..1000000).each{|a| a+1}
    end

    def test_labels_creator
      issues = Gharial::Issues.labels(['bug']).creator('marcheb').execute

      assert_equal(2, issues.count)
      assert_equal("There's a bug here", issues.first.title )
      (1..1000000).each{|a| a+1}
    end
  end
end
