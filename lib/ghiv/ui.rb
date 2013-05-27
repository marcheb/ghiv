module Ghiv
  class UI
    class << self
      def comments(records)
        puts "comment_id: " + records.id.to_s
        puts "comment_body: " + Emoji.parser(records.body) if not records.body.empty?
        puts "comment_creator: " + records.user['login']
      end

      def issue(records, options={comments: nil})
        puts "issue_number: #{records.number}"
        puts "title: #{records.title}"
        puts "body:" + Emoji.parser(records.body) if not records.body.empty?
        puts "labels: #{ records.labels.map{ |l| l['name'] }.join(',') }"
        puts "created_at: #{records.created_at}"
        puts "state: #{records.state}"
        puts "html_url: #{records.html_url}"
        puts "url: #{records.url}"
        puts "creator: #{records.user['login']}"
        puts "assignee: #{records.assignee['login']}" if records.assignee
        puts "comments: #{records.comments}"
        if records.milestone
          puts "milestone_id: #{records.milestone['id']}"
          puts "milestone_title: #{records.milestone['title']}"
          puts "milestone_description: #{records.milestone['description']}" if records.milestone['description']
          puts "milestone_url: #{records.milestone['url']}"
          puts "milestone_due_on: #{records.milestone['due_on']}" if records.milestone['due_on']
        end
      end

      def issues(records)
        records.each { |i| puts "#{i.number}, #{i.title}" }
      end

      def puts(msg)
        Config.out_stream.puts(msg) if Config.out_stream
      end

      def raw(issues)
        puts JSON.pretty_generate issues
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
