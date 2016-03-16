module PdfHelper

  def self.parse_pdf(reader, user)
    p reader.info
    @skill = Skill.new(title: "I can parse pdfs!")
    git auser.skills << @skill
  end


end
