class ResumesController < ApplicationController

  def index
    # @resumes = Resume.all
    resume = Resume.create(target_job: "Rockstar", document_data: "Who runs the world? Squirrels!")
    resume2 = Resume.create(target_job: "Gardner", document_data: "Who runs the world? Squirrels!")
    @resumes = [resume, resume2]
  end

end
