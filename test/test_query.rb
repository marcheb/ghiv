module Test
  require File.expand_path(File.dirname(__FILE__)) + '/../lib/ghiv'
  require "test/unit"

  class TestQuery < Test::Unit::TestCase
    def test_set_from_config
      query = Ghiv::Query.new
      queries = {'query_creator' => 'marcheb', 'query_direction' => 'asc', 'query_labels' => 'label1,label2', 'query_milestone' => '2', 'query_sort' => 'created', 'query_state' => 'open'}
      queries.each { |k,v| Ghiv::Config.send("#{k}=",v) }
      query.set_from_config

      queries.each { |k,v| assert_equal(query.send(k.gsub('query_','')), v) }
    end
  end
end
