puts "issue_number: #{args[0].number}"
puts "title: #{args[0].title}"
puts "body:" + Emoji.parser(args[0].body) if not args[0].body.empty?
puts "labels: #{ args[0].labels.map{ |l| l['name'] }.join(',') }"
puts "created_at: #{args[0].created_at}"
puts "state: #{args[0].state}"
puts "html_url: #{args[0].html_url}"
puts "url: #{args[0].url}"
puts "creator: #{args[0].user['login']}"
puts "assignee: #{args[0].assignee['login']}" if args[0].assignee
puts "comments: #{args[0].comments}"
if args[0].milestone
  puts "milestone_id: #{args[0].milestone['id']}"
  puts "milestone_title: #{args[0].milestone['title']}"
  puts "milestone_description: #{args[0].milestone['description']}" if args[0].milestone['description']
  puts "milestone_url: #{args[0].milestone['url']}"
  puts "milestone_due_on: #{args[0].milestone['due_on']}" if args[0].milestone['due_on']
end
