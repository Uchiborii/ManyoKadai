FactoryBot.define do
  factory :user do
    id { 1 }
    name { "kirin" }
    email { "kirin@gmail.com" }
    password { "password123" }
    password_confirmation { "password123" }
    admin { false }
  end
  factory :admin_user, class: User do
    id { 2 }
    name { "admin" }
    email { "adminn@gmail.com" }
    password { "password123" }
    password_confirmation { "password123" }
    admin { true }
  end
end
