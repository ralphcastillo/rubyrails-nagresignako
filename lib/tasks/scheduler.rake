desc "This task is called by the Heroku scheduler add-on"
task :social_push => :environment do
  #include ActionDispatch::Routing::UrlFor
  #include ActionController::UrlFor  #requires a request object
  #include Rails.application.routes.url_helpers

  #default_url_options[:host] = 'secret-falls-8426.herokuapp.com'
  
  #puts "Pushing Top Message to Social Media"
  #PostQueue.social_push
  #puts "Social Push : Done"
  open('http://www.nagresignako.com/admin_actions/consume_queue?secret_push_message=e05e121f2ca8d1180eb49e37b761533e').read
end

task :test_rake => :environment do
  include ActionDispatch::Routing::UrlFor
  #include ActionController::UrlFor  #requires a request object
  include Rails.application.routes.url_helpers
end

task :grab_top => :environment do
  Post.queue_top
end