# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Website.destroy_all
Tag.destroy_all
Resume.destroy_all
ResumeAsset.destroy_all
Tagging.destroy_all
Objective.destroy_all
Skill.destroy_all
Volunteering.destroy_all
Experience.destroy_all
Project.destroy_all
Education.destroy_all
Description.destroy_all
Describing.destroy_all

# mode = "development"
mode = "demo"

if mode == "demo"
  lindsey = User.new

  lindsey.first_name = "Lindsey"
  lindsey.last_name = "Ullman"
  lindsey.phone_number = "555-555-5555"
  lindsey.email = "lindsey.ullman@gmail.com"
  lindsey.confirmed_at = Date.today
  lindsey.password = "password"
  lindsey.save

  astronaut = Resume.create(target_job: "Astronaut")
  lindsey.resumes << astronaut
  lindsey.resumes << Resume.create(target_job: "Developer")
  lindsey.resumes << Resume.create(target_job: "Teacher")
  lindsey.resumes << Resume.create(target_job: "Accountant")

  dev_tag = Tag.create(name: "Developer", user_id: lindsey.id)
  cs_tag = Tag.create(name: "Customer Service", user_id: lindsey.id)
  hc_tag = Tag.create(name: "Healthcare", user_id: lindsey.id)
  auto_tag = Tag.create(name: "Process Automation", user_id: lindsey.id)
  lead_tag = Tag.create(name: "Leadership", user_id: lindsey.id)
  retail_tag = Tag.create(name: "Retail", user_id: lindsey.id)
  fe_tag = Tag.create(name: "Front End Dev", user_id: lindsey.id)
  be_tag = Tag.create(name: "Back End Dev", user_id: lindsey.id)
  w_tag = Tag.create(name: "Warehouse", user_id: lindsey.id)

  # lindsey.tags << [ dev_tag, cs_tag, hc_tag, auto_tag, lead_tag, retail_tag, fe_tag, be_tag, w_tag ]

  objective = Objective.create(description:"To develop web based applications.", user_id: lindsey.id)
  objective.save
  objective.tags << [dev_tag, fe_tag, be_tag]

  objective = Objective.create(description:"Work with clients to develop customized applications to fit their business needs.", user_id: lindsey.id)
  objective.save
  objective.tags << [dev_tag, fe_tag, be_tag, auto_tag]

  objective = Objective.create(description:"Develop applications to improve healthcare business operations.", user_id: lindsey.id)
  objective.save
  objective.tags << [dev_tag, fe_tag, be_tag, hc_tag, auto_tag]

  experience = Experience.create(
    company: "MicroAge", 
    title: "Materials Handler", 
    description: "Warehouse Employee", 
    begin_date: "1999-08-01", 
    end_date: "2000-02-01", 
    location: "Tempe, AZ", user_id: lindsey.id)
  experience.save
  experience.tags << w_tag
  description = Description.create(detail: "Moved products from receiving area to stock area.")
  experience.descriptions << description
  description = Description.create(detail: "Operated forklifts and other warehouse equipment.")
  experience.descriptions << description
  description = Description.create(detail: "Prioritized queue of incoming stock to maximize efficiency.")
  experience.descriptions << description
  description = Description.create(detail: "Unloaded delivery trucks.")
  experience.descriptions << description

  experience = Experience.create(
    company: "Home Base", 
    title: "Cashier", 
    description: "Cashier", 
    begin_date: "2000-03-01", 
    end_date: "2000-06-01", 
    location: "Scottsdale, AZ", user_id: lindsey.id)
  experience.save
  experience.tags << [cs_tag, retail_tag] 
  description = Description.create(detail: "Operated point of sale system to ring up customer purchases.")
  experience.descriptions << description
  description = Description.create(detail: "Assisted customers with product questions.")
  experience.descriptions << description
  description = Description.create(detail: "Assisted customers with loading cars.")
  experience.descriptions << description
  description = Description.create(detail: "Reconciled cash drawer to purchases nightly.")

  experience = Experience.create(
    company: "AllTel Ice Den", 
    title: "Public Session Supervisor", 
    description: "Ice Rink", 
    begin_date: "2000-03-01", 
    end_date: "2005-07-01", 
    location: "Scottsdale, AZ", user_id: lindsey.id)
  experience.save
  experience.tags << [retail_tag, cs_tag, lead_tag]
  description = Description.create(detail: "Supervised operations during public skating events.")
  experience.descriptions << description
  description = Description.create(detail: "Administrered first aid to customers.")
  experience.descriptions << description
  description = Description.create(detail: "Assisted customers with questions")
  experience.descriptions << description
  description = Description.create(detail: "Supervised staff to clean and prepare the facility for the next day.")
  experience.descriptions << description

  experience = Experience.create(
    company: "Optum360", 
    title: "Systems Analyst", 
    description: "Healthcare Business Office", 
    begin_date: "2000-06-30", 
    end_date: "2016-03-01", 
    location: "Phoenix, AZ", user_id: lindsey.id)
  experience.save
  experience.tags << [hc_tag, auto_tag, dev_tag]
  description = Description.create(detail: "Improved processes throughout the PFS department.")
  experience.descriptions << description
  description = Description.create(detail: "Automated scripts, tasks, and other reports to provide consistent departmental information.")
  experience.descriptions << description
  description = Description.create(detail: "Improved cash collection efforts for large hospital chain.")
  experience.descriptions << description
  description = Description.create(detail: "Created a payment assistance application to help provide charitable care to patients in financial need.")
  experience.descriptions << description
  description = Description.create(detail: "Worked on a transition team to smoothly migrate department into a new coprporate structure.")
  experience.descriptions << description

  experience = Experience.create(
    company: "Dev Bootcamp", 
    title: "Developer", 
    description: "Make beautiful and meaningful things.", 
    begin_date: "2016-01-18", 
    end_date: "2016-03-18", 
    location: "San Francisco, CA", user_id: lindsey.id)
  experience.save
  experience.tags << [dev_tag, cs_tag, auto_tag, fe_tag, be_tag]
  description = Description.create(detail: "Worked on agile project teams to build full stack web applications.")
  experience.descriptions << description
  description = Description.create(detail: "Learned both front-end and back-end development.")
  experience.descriptions << description
  description = Description.create(detail: "Logged over 1000 hours of development time in a fast paced sprint evironment.")
  experience.descriptions << description
  description = Description.create(detail: "Worked with a client to build applications to specifications requested.")
  experience.descriptions << description

  education = Education.create(
    institution_name: "Montana State University", 
    description: "Computer Science", 
    completion: "1999-04-01", 
    location: "Bozeman, MT", 
    focus: "Computer Science", user_id: lindsey.id)
  education.save
  education.tags << [dev_tag]
  description = Description.create(detail: "Studied Computer Science.")
  education.descriptions << description
  description = Description.create(detail: "Elected to the dormitory residence hall association.")
  education.descriptions << description

  education = Education.create(
    institution_name: "Paradise Valley Community College", 
    description: "Associates Degree", 
    completion: "2013-08-01", 
    location: "Phoenix, AZ", 
    focus: "Computer Information Systems", user_id: lindsey.id)
  education.save
  education.tags << [dev_tag]
  description = Description.create(detail: "Earned Associate of Applied Science degree.")
  education.descriptions << description
  description = Description.create(detail: "Graduated with high honors.")
  education.descriptions << description


  education = Education.create(
    institution_name: "Arizona State University", 
    description: "Software Engineering", 
    completion: "2015-08-01", 
    location: "Tempe, AZ",
    focus: "Software Engineering", user_id: lindsey.id)
  education.save
  education.tags << [dev_tag]
  description = Description.create(detail: "Studied Software Engineering")
  education.descriptions << description
  description = Description.create(detail: "Ira A Fulton School of Engineering")
  education.descriptions << description

  project = Project.create(
    title: "Mod Resume", 
    description: "Built a modular resume application", user_id: lindsey.id)
  project.save
  project.tags << [dev_tag, fe_tag, be_tag]
  description = Description.create(detail: "Worked in an agile team to build a full stack application.")
  project.descriptions << description
  description = Description.create(detail: "Set up complex polymorphic database associations.")
  project.descriptions << description
  description = Description.create(detail: "Integrated user friendly drag and drop technology.")
  project.descriptions << description

  project = Project.create(
    title: "Transformational Care", 
    description: "Improved business office operations", user_id: lindsey.id)
  project.save
  project.tags << [hc_tag, auto_tag, dev_tag]
  description = Description.create(detail: "Implemented lean methods to improve business processes")
  project.descriptions << description
  description = Description.create(detail: "Worked with external vendors and consultants.")
  project.descriptions << description
  description = Description.create(detail: "Streamlined reporting of departmental assets.")
  project.descriptions << description

  project = Project.create(
    title: "Payment Assistance Application", 
    description: "Built a charity application", user_id: lindsey.id)
  project.save
  project.tags << [dev_tag, fe_tag, be_tag, hc_tag, auto_tag]
  description = Description.create(detail: "Worked with customer service department to serve needs of patients.")
  project.descriptions << description
  description = Description.create(detail: "Followed government guidelines regarding poverty levels.")
  project.descriptions << description
  description = Description.create(detail: "Improved process for the entry and tracking of charity applications.")
  project.descriptions << description

  skill = Skill.create(
    title: "Customer Service", user_id: lindsey.id)
  skill.save
  skill.tags << [cs_tag]

  skill = Skill.create(
    title: "Ruby on Rails", user_id: lindsey.id)
  skill.save
  skill.tags << [dev_tag, be_tag]

  skill = Skill.create(
    title: "Sinatra", user_id: lindsey.id)
  skill.save
  skill.tags << [dev_tag, be_tag]

  skill = Skill.create(
    title: "JavaScript", user_id: lindsey.id)
  skill.save
  skill.tags << [dev_tag, fe_tag]

  skill = Skill.create(
    title: "Active Record", user_id: lindsey.id)
  skill.save
  skill.tags << [dev_tag, be_tag]

  skill = Skill.create(
    title: "Agile Workflow", user_id: lindsey.id)
  skill.save
  skill.tags << [dev_tag]

  skill = Skill.create(
    title: "Perl", user_id: lindsey.id)
  skill.save
  skill.tags << [dev_tag]

  skill = Skill.create(
    title: "Process Improvement", user_id: lindsey.id)
  skill.save
  skill.tags << [auto_tag]

  skill = Skill.create(
    title: "Task Automation", user_id: lindsey.id)
  skill.save
  skill.tags << [auto_tag]

  volunteering = Volunteering.create(
    organization: "Pat Tillman Foundation", 
    title: "Active Fundraiser", 
    description: "Military scholarship foundation", 
    begin_date: "2010-01-18", 
    end_date: "2016-03-18", 
    location: "Tempe, AZ", user_id: lindsey.id)
  volunteering.save
  volunteering.tags << [cs_tag]
  description = Description.create(detail: "Fundraised for annual Pat's Run Event")
  volunteering.descriptions << description 
  description = Description.create(detail: "Participate annually in Pat's Run")
  volunteering.descriptions << description 
end

if mode == "development"

  10.times do
    # *****************************
    # Create User
    # *****************************
    name = Faker::StarWars.character
    if name.include? " "
      first_name = name.split(" ").first
      last_name = name.split(" ").last
    else
      first_name = name
      last_name = name
    end
    username = Faker::Internet.user_name("#{first_name} #{last_name}", %w(. _ -))
    new_user = User.create(
      # email: Faker::Internet.free_email(username),
      email: "lindsey.ullman@gmail.com",
      first_name: first_name,
      last_name: last_name,
      phone_number: Faker::PhoneNumber.phone_number,
      password: "password")

    Website.create(description: "LinkedIn", url: Faker::Internet.url('linkedin.com', "/#{username}"), user_id: new_user.id)
    Website.create(description: "GitHub", url: Faker::Internet.url('github.com', "/#{username}"), user_id: new_user.id)

    # *****************************
    # Create User's Tags
    # *****************************
    rand(1..4).times do
      Tag.create(user_id: new_user.id, name: Faker::StarWars.planet)
    end

    rand(1..2).times do
      Tag.create(user_id: new_user.id, name: Faker::StarWars.droid)
    end


    # *****************************
    # Create User's Experiences w/tags
    # *****************************
    rand(1..3).times do
      asset = Experience.create(
        company: Faker::Company.name,
        title: Faker::Company.profession,
        begin_date: Faker::Date.between(5.years.ago, Date.today),
        end_date: Faker::Date.between(5.years.ago, Date.today),
        description: Faker::Company.bs,
        location: Faker::Address.city,
        user_id: new_user.id)
      rand(1..(new_user.tags.count)).times do
        asset.tags << new_user.tags.sample
      end
      rand(1..7).times do
        description = Description.create(detail: Faker::Company.bs)
        asset.descriptions << description
      end
    end


    # *****************************
    # Create User's Volunteering w/tags
    # *****************************
    rand(1..3).times do
      asset = Volunteering.create(
        organization: Faker::Company.name,
        title: Faker::Company.profession,
        begin_date: Faker::Date.between(5.years.ago, Date.today),
        end_date: Faker::Date.between(5.years.ago, Date.today),
        description: Faker::Company.bs,
        location: Faker::Address.city,
        user_id: new_user.id)
      rand(1..(new_user.tags.count)).times do
        asset.tags << new_user.tags.sample
      end
      rand(1..7).times do
        description = Description.create(detail: Faker::Company.bs)
        asset.descriptions << description
      end
    end


    # *****************************
    # Create User's Educations w/tags
    # *****************************
    rand(1..3).times do
      asset = Education.create(
        institution_name: Faker::University.name,
        completion: Faker::Date.between(5.years.ago, Date.today),
        description: Faker::Company.bs,
        focus: "Studies",
        location: Faker::Address.city,
        user_id: new_user.id)
      rand(1..(new_user.tags.count)).times do
        asset.tags << new_user.tags.sample
      end
      rand(1..7).times do
        description = Description.create(detail: Faker::Company.buzzword)
        asset.descriptions << description
      end
    end

    # *****************************
    # Create User's Objectives w/tags
    # *****************************
    rand(1..3).times do
      asset = Objective.create(
        description: Faker::Company.bs,
        user_id: new_user.id)
      rand(1..(new_user.tags.count)).times do
        asset.tags << new_user.tags.sample
      end
      rand(1..7).times do
        description = Description.create(detail: Faker::Company.catch_phrase)
        asset.descriptions << description
      end
    end


    # *****************************
    # Create User's Skills w/tags
    # *****************************
    rand(1..3).times do
      asset = Skill.create(
        title: Faker::Company.buzzword,
        user_id: new_user.id)
      rand(1..(new_user.tags.count)).times do
        asset.tags << new_user.tags.sample
      end
      rand(1..7).times do
        description = Description.create(detail: Faker::Company.profession)
        asset.descriptions << description
      end
    end

    # *****************************
    # Create User's Projects w/tags
    # *****************************
    rand(1..3).times do
      asset = Project.create(
        title: Faker::Hacker.ingverb,
        description: Faker::Hacker.say_something_smart,
        user_id: new_user.id)
      rand(1..(new_user.tags.count)).times do
        asset.tags << new_user.tags.sample
      end
      rand(1..7).times do
        description = Description.create(detail: Faker::Commerce.product_name)
        asset.descriptions << description
      end
    end

    # *****************************
    # Create User's Resume w/tags
    # *****************************
    new_resume = Resume.create(target_job: Faker::Company.profession, user_id: new_user.id)
    rand(1..(new_user.tags.count)).times do
      new_resume.tags << new_user.tags.sample
    end

    # *****************************
    # Create Resume Assets
    # *****************************
    2.times do
      new_resume.experiences << new_user.experiences.sample
      new_resume.objectives << new_user.objectives.sample
      new_resume.projects << new_user.projects.sample
      new_resume.skills << new_user.skills.sample
      new_resume.educations << new_user.educations.sample
      new_resume.volunteerings << new_user.volunteerings.sample
    end

  end
end


puts "New Users Summary:"
puts "******************"
User.all.each do |user|
  puts "#{user.id}: #{user.first_name} #{user.last_name} (#{user.email})"
end
