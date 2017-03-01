# Tasking App

I was doing work for a client and trying hard to keep them up-to-speed on what was accomplished everyday. That meant that I was wasting time writing emails, while I could be coding. So I decided to create an app to keep track of my projects and tasks for those projects and that would create a daily report that I can email to a client with a summary of the tasks worked on that day.

Feel free to create an account and play with it in [here](https://sam-task-force.herokuapp.com/)

If you want to clone and deploy it yourself, here is the basic information:

* Ruby: 2.4.0
* Rails: 5.0.1
* Database: Postgresql

* After cloning:
  - Bundle Install
  - Rails db:create && rails db:migrate
* To run tests: type rspec on the terminal

### MAILER  
* Don't forget to change your email settings in production.rb:
  ```ruby
  config.action_mailer.default_url_options = { :host => "sam-task-force.herokuapp.com" }
  ```
* Use the sendgrid add-on with heroku
* Change application_mailer.rb
```ruby
class ApplicationMailer < ActionMailer::Base
  default from: '<your email goes here >'
  layout 'mailer'
end
```
