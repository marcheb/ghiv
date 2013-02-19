module Test
  require File.expand_path(File.dirname(__FILE__)) + '/../lib/ghiv'
  require "test/unit"

  class TestIssues < Test::Unit::TestCase
    def test_all
      issues = Ghiv::Issues.all.execute

      assert_equal(3, issues.count)
      assert_equal("i'm 12 what is this", issues.first.title )
    end

    def test_creator
      issues = Ghiv::Issues.creator('marcheb').execute

      assert_equal(2, issues.count)
      assert_equal("There's a bug here", issues.first.title )
    end

    def test_direction
      assert_equal("2012-11-10T20:56:50Z", Ghiv::Issues.direction('asc').execute.first.created_at )
      assert_equal("2012-11-14T13:40:16Z", Ghiv::Issues.direction('desc').execute.first.created_at )
    end

    def test_labels
      issues = Ghiv::Issues.labels(['bug', 'duplicate']).execute

      assert_equal(1, issues.count)
      assert_equal("There's a bug here", issues.first.title )
    end

    def test_labels_creator
      issues = Ghiv::Issues.labels(['bug']).creator('marcheb').execute

      assert_equal(2, issues.count)
      assert_equal("There's a bug here", issues.first.title )
    end

    def test_unknown_method
      assert_raise NoMethodError do
        Ghiv::Issues.unknown
      end
    end

    def test_sort
      assert_equal(3, Ghiv::Issues.sort('comments').execute.first.number)
      assert_equal(3, Ghiv::Issues.sort('created').execute.first.number)
      assert_equal(3, Ghiv::Issues.sort('updated').execute.first.number)
    end
  end
end
