desc "This task is called by the Heroku scheduler add-on"
task :daily_admin => :environment do
  
  puts "assign points to any volunteer who baby sat yesterday"
  
  puts "done"
  
  puts "Deleting old requests"
  Request.delete_old
  puts "done."
  
  puts "send out reminders for any requests due to happen today"
  
  Request.where("date = ? and volunteer_id not null", Date.today).each do |r|
    RequestMailer.babysitting_reminder(r).deliver
  end
  
  puts "done"
  
end

