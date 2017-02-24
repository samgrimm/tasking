
@user = User.create(email: "email@test.com",
                    password:"foobar",
                    password_confirmation:"foobar",
                    availability: 6
                    )
puts "1 User created"

@client = User.create(email: "email1@test.com",
                    password:"foobar",
                    password_confirmation:"foobar",
                    type: "Client"
                    )
@client2 = User.create(email: "email2@test.com",
                    password:"foobar",
                    password_confirmation:"foobar",
                    type: "Client"
                    )
puts "2 Clients created"

description = "Gillyflower balloon flower obedient plant spotted orchid.
        Florist’s nighmare pasqueflower stock montbretia ox-eye daisy
        michaelmas daisy prairie gentian. Flower dandelion spray carnation
        turtle head dill. Bloody crane's-bill moth orchid, flowering cherry
        snow berry sweet sultan sturt's desert rose. Mistletoe brodiaea
        scorpion orchid coneflower cockscomb lady’s slipper orchid."


Project.create(name: "Project 1", user_id: @user.id, status: 0, start_date: (Date.today - 6.days), description: description, client_id: @client.id)
Project.create(name: "Project 2", user_id: @user.id, status: 1, start_date: (Date.today - 13.days), description: description, client_id: @client2.id)
Project.create(name: "Project 3", user_id: @user.id, status: 2, start_date: (Date.today - 20.days), description: description, client_id: @client.id, actual_end_date: Date.today)

Project.create(name: "Project 4", user_id: @user.id, status: 3, start_date: (Date.today + 6.days), description: description, client_id: @client2.id)
Project.create(name: "Project 5", user_id: @user.id, status: 0, start_date: (Date.today + 13.days), description: description, client_id: @client.id)
Project.create(name: "Project 6", user_id: @user.id, status: 0, start_date: (Date.today + 20.days), description: description, client_id: @client2.id)
puts "6 projects created"

@projects = Project.all

@projects.each do |project|
  n = 0
  15.times do |task|
    n = n + 1
    task = project.tasks.create(estimated_start_date: (project.start_date + n.days),
                         duration: 20,
                         name: "#{n}th_task for project #{project.name}",
                         status: 0)
    task.calculate_end_date
  end
end

puts "90 tasks created - 15 for each project"
