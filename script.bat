heroku destroy --app IdeaKast
heroku create IdeaKast
git push heroku master
heroku rake db:migrate --trace
heroku rake db:seed --trace