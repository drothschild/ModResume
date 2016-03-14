require 'rails_helper'

RSpec.feature "User", type: :feature, js: true do
  factory :user do
    first_name "Joe"
    last_name  "Blow"
    email { "#{first_name}.#{last_name}@example.com".downcase }
  end


end
