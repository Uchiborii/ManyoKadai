FactoryBot.define do
  factory :user do
    id { 1 }
    name { "kirin" }
    email { "kirin@gmail.com" }
    password_digest { "123456" }
    admin { false }
  end
  factory :admin_user, class: User do
    id { 2 }
    name { "admin" }
    email { "adminn@gmail.com" }
    password_digest { "123456" }
    admin { true }
  end
end
