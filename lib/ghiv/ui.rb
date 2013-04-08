module Ghiv
  class UI
    class << self
      def list(issues)
        issues.each { |i| puts "#{i.number}, #{i.title}" }
      end

      def puts(msg)
        Config.out_stream.puts(msg) if Config.out_stream
      end

      def raw(issues)
        puts JSON.pretty_generate issues
      end

      def show(issue, options={comments: nil})
        puts "issue_number: #{issue.number}"
        puts "title: #{issue.title}"
        puts "body:" + Emoji.parser(issue.body) if not issue.body.empty?
        puts "labels: #{ issue.labels.map{ |l| l['name'] }.join(',') }"
        puts "created_at: #{issue.created_at}"
        puts "state: #{issue.state}"
        puts "html_url: #{issue.html_url}"
        puts "url: #{issue.url}"
        puts "creator: #{issue.user['login']}"
        puts "assignee: #{issue.assignee['login']}" if issue.assignee
        puts "comments: #{issue.comments}"
        if issue.milestone
          puts "milestone_id: #{issue.milestone['id']}"
          puts "milestone_title: #{issue.milestone['title']}"
          puts "milestone_description: #{issue.milestone['description']}" if issue.milestone['description']
          puts "milestone_url: #{issue.milestone['url']}"
          puts "milestone_due_on: #{issue.milestone['due_on']}" if issue.milestone['due_on']
        end

        if options[:comments]
          options[:comments].each do |c|
            puts "comment_id: " + c.id.to_s
            puts "comment_body: " + c.body
            puts "comment_creator: " + c.user['login']
          end
        end
      end

      module Emoji
        def self.candidates(text)
          text.scan(/:(.*?):/).flatten.compact
        end

        def self.parser(text)
          candidates(text).each do |c|
            drawing = Askiimoji::Dictionnary.emoji(c)
            text.gsub!( ":#{c}:", drawing ) if drawing
          end
          text
        end
      end
    end
  end
end
