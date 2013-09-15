module Ghiv
  class UI
    def initialize(service, records)
      @service = service
      @records = records
    end

    def issue
      puts "issue_number: #{@records['number']}"
      puts "title: #{@records['title']}"
      puts "body:" + Emoji.parser(@records['body']) if not @records['body'].empty?
      puts "labels: #{ @records['labels'].map{ |l| l['name'] }.join(',') }"
      puts "created_at: #{@records['created_at']}"
      puts "state: #{@records['state']}"
      puts "html_url: #{@records['html_url']}"
      puts "url: #{@records['url']}"
      puts "creator: #{@records['user']['login']}"
      puts "assignee: #{@records['assignee']['login']}" if @records['assignee']
      puts "comments: #{@records['comments']}"
      milestone(@records['milestone']) if @records['milestone']
    end

    def issues
      @records.each { |i| puts "#{i['number']}, #{i['title']}" }
    end

    def milestone(milestone)
      puts "milestone_id: #{milestone['id']}"
      puts "milestone_title: #{milestone['title']}"
      puts "milestone_description: #{milestone['description']}" if milestone['description']
      puts "milestone_url: #{milestone['url']}"
      puts "milestone_due_on: #{milestone['due_on']}" if milestone['due_on']
    end

    def puts(msg)
      Config.out_stream.puts(msg) if Config.out_stream
    end

    def raw
      puts Config.pretty_json ? JSON.pretty_generate(@records) : @records
    end

    def render
      Config.raw ? raw : self.send(@service)
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
