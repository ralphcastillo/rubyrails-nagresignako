desc "This task is called by the Heroku scheduler add-on"
task :social_push => :environment do
  puts "Pushing Top Message to Social Media"
  PostQueue.social_push
  puts "Social Push : Done"
end