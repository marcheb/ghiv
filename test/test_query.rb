module Test
  require File.expand_path(File.dirname(__FILE__)) + '/../lib/ghiv'
  require "test/unit"

  class TestQuery < Test::Unit::TestCase
    def test_params
      assert_equal([:creator, :direction, :labels, :milestone, :sort, :state], Ghiv::Query.params)
    end

    def test_format_value
      assert_equal('list1,list2', Ghiv::Query.format_value(['list1','list2']))
      assert_equal('elem1', Ghiv::Query.format_value('elem1'))
    end

    def test_parse
      query = Ghiv::Query.new
      queries.each { |k,v| query.send(k,v) }

      query.parse
      queries.each { |k,v| assert query.elements.include?("#{k}=#{Ghiv::Query.format_value v}") }
    end

    def test_set_from_config
      query = Ghiv::Query.new

      queries.each { |k,v| Ghiv::Config.send("query_#{k}=",v) }
      query.set_from_config

      queries.each { |k,v| assert_equal(v, query.send(k)) }
    end

    def queries
      {'creator' => 'marcheb', 'direction' => 'asc', 'labels' => ['label1', 'label2'], 'milestone' => '2', 'sort' => 'created', 'state' => 'open'}
    end
  end
end
