desc "This task is called by the Heroku scheduler add-on"
task :daily_admin => :environment do
  
  puts "assign points to any volunteer who baby sat yesterday"
  Request.award_points
  puts "done"
  
  puts "Deleting old requests"
  Request.delete_old
  puts "done."
  
  puts "send out reminders for any requests due to happen today"
  Request.todays_reminders
  puts "done"
  
end

