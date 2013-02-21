desc "This task is called by the Heroku scheduler add-on"
task :social_push => :environment do
  include ActionDispatch::Routing::UrlFor
  #include ActionController::UrlFor  #requires a request object
  include Rails.application.routes.url_helpers

  default_url_options[:host] = 'http://secret-falls-8426.herokuapp.com'
  
  puts "Pushing Top Message to Social Media"
  PostQueue.social_push
  puts "Social Push : Done"
end

task :test_rake => :environment do
  include ActionDispatch::Routing::UrlFor
  #include ActionController::UrlFor  #requires a request object
  include Rails.application.routes.url_helpers
end