module Ghiv
  class UI
    class << self
      def list(issues)
        issues.each { |i| puts "#{i.number}, #{i.title}" }
      end

      def puts(msg)
        Config.out_stream.puts(msg) if Config.out_stream
      end

      def show(issue)
        puts "issue number: #{issue.number}"
        puts "title: #{issue.title}"
        puts "body:"
        puts issue.body
        puts "created_at: #{issue.created_at}"
        puts "state: #{issue.state}"
        puts "html_url : #{issue.html_url}"
        puts "url : #{issue.url}"
      end
    end
  end
end
