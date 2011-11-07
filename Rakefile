require './application'

desc "Daily importing"

task :import do

end

task :setup do
  sh "heroku create"
  sh "git push heroku master"
  sh "heroku open"
end
