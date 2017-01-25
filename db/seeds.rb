
@user = User.create(email: "email@test.com",
                    password:"foobar",
                    password_confirmation:"foobar"
                    )
puts "1 User created"

@client = User.create(email: "email@test.com",
                    password:"foobar",
                    password_confirmation:"foobar",
                    type: "Client"
                    )
puts "1 Client created"

Project.create(name: "Project 1", user_id: @user.id, status: 0, start_date: (Date.today - 6.days), client: @client)
Project.create(name: "Project 2", user_id: @user.id, status: 1, start_date: (Date.today - 13.days), client: @client)
Project.create(name: "Project 3", user_id: @user.id, status: 2, start_date: (Date.today - 20.days), client: @client, actual_end_date: Date.today)

Project.create(name: "Project 4", user_id: @user.id, status: 3, start_date: (Date.today + 6.days), client: @client)
Project.create(name: "Project 5", user_id: @user.id, status: 0, start_date: (Date.today + 13.days), client: @client)
Project.create(name: "Project 6", user_id: @user.id, status: 0, start_date: (Date.today + 20.days), client: @client)
puts "6 projects created"

@projects = Project.all

@projects.each do |project|
  n = 0
  15.times do |task|
    n = n + 1
    project.tasks.create(estimated_start_date: (project.start_date + n.days),
                         duration: 20,
                         name: "#{n}th_task for project #{project.name}",
                         status: 0)
  end
end

puts "90 tasks created - 15 for each project"
