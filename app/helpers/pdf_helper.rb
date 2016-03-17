module PdfHelper

  def self.parse_pdf(reader, user)
    @skill = Skill.new(title: "I can parse pdfs!")
    user.skills << @skill
  end


end
