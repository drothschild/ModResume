module AuthHelper
  def http_login
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
    email: Faker::Internet.free_email(username),
    first_name: first_name,
    last_name: last_name,
    phone_number: Faker::PhoneNumber.phone_number,
    password: "hello")

    user = new_user.email
    pw = 'hello'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
end

module AuthRequestHelper
  #
  # pass the @env along with your request, eg:
  #
  # GET '/labels', {}, @env
  #
  def http_login
    @env ||= {}
    user = 'gunray.nute@hotmail.com'
    pw = 'hello'
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
end

