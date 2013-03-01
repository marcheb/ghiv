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
        puts Emoji.parser(issue.body) if not issue.body.empty?
        puts "labels: #{ issue.labels.map{ |l| l['name'] }.join(',') }"
        puts "created_at: #{issue.created_at}"
        puts "state: #{issue.state}"
        puts "html_url : #{issue.html_url}"
        puts "url : #{issue.url}"
      end

      module Emoji
        def self.parser(text)
          text.gsub!(':mushroom:', mushroom)
        end

        def self.mushroom
          <<-eos
               n
              / `\\
             (___:)
              """"
               ||
               ||
               ))
              //
             ((
              \\\\\\
               ))
               ||
          eos
        end
      end
    end
  end
end
