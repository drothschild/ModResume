require 'date'

module PdfHelper

  def self.parse_pdf(reader, user)
    all_lines = []
    reader.pages.each do |page|
      page_array = page.text.split("\n")
      page_array.each do |line|
        all_lines << line if line != ""
      end
    end

    summary = []
    experience = []
    skills = []
    education = []


    i = 0
    # skip heading
    while all_lines[i] != "Summary" do
      i += 1
    end

    # skip the word "Summary"
    i += 1

    # get summary
    while all_lines[i] != "Experience" do
      summary << all_lines[i]
      i += 1
    end

    # skip the word "Experience"
    i += 1

    # get experience
    while all_lines[i] != "Skills & Expertise"
      experience << all_lines[i]
      i += 1
    end

    # skip the word "Skills & Expertise"
    i += 1

    # get skills
    while all_lines[i] != "Education"
      skills << all_lines[i]
      i += 1
    end

    # skip the word "Education"
    i += 1

    # get education
    while all_lines[i] != "Courses"
      education << all_lines[i]
      i += 1
    end

    make_objective(summary, user)
    make_skills(skills, user)
    make_experiences(experience, user)
    make_

    p experience

    # binding.pry
  end

  def self.make_objective(array, user)
    user.objectives << Objective.create(description: array.join(""))
  end

  def self.make_skills(array, user)
    array.each do |skill|
      user.skills << Skill.create(title: skill)
    end
  end

  def self.make_experiences(array, user)
    i = -1
    key = ""
    experience_sections = {}
    array.each do |subarray|
      if subarray.include?(" at ")
        key = subarray
        experience_sections[key] = []
      else
        experience_sections[key] << subarray
      end
    end
    experience_sections.each do |key, value|
      title_company = key.split(" at ")
      @experience = Experience.new(company: title_company[1], title: title_company[0])
      dates = value[0]
      dates = dates.split("-")
      @experience.begin_date = make_dates(dates[0])
      end_date = dates[1].split("(")[0] if dates[1] != nil
      @experience.end_date = make_dates(end_date)
      @experience.descriptions << Description.create(detail: value[1..-1].join("").gsub("  ", ""))
      @experience.save
    end
  end

  def self.make_dates(string)
    return Date.today if string == nil
    begin
      Date.parse(string)
    rescue ArgumentError
      Date.today
    end
  end

end
