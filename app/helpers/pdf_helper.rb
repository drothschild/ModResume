module PdfHelper

  def self.parse_pdf(reader)
    p reader.info
    @user = current_user
    @skill = Skill.new(title: "I can parse pdfs!")
    @user.skills << @skill
  end


end
