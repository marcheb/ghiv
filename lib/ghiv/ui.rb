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
          list.each { |l| text.gsub!(":#{l.to_s}:", send(l.to_s)) }
          text
        end

        def self.list
          [:mushroom, :toilet, :shower]
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

        def self.toilet
          <<-eos

           .__   .-".
          (o\\"\\  |  |
             \\_\\ |  |
            _.---:_ |
           ("-..-" /
            "-.-" /
              /   |
              "--"  AsH
          eos
        end

        def self.shower
          <<-eos

                    ,------|
                   []      |
                   !!      |
                   ! ,     |
                 _,~,\\     |
                 \\)))/     |
                 ((((,     |
                  ) (      |
                 (( \\      |
                 |/` \\     |
                 (| (/     |
          ejm98  -_ -_    _|_
          eos
        end
      end
    end
  end
end
