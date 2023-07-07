FactoryBot.define do
  factory :label do
    name { "日用品" }
  end
  factory :label1, class: Label do
    name { "娯楽" }
  end
  factory :label2, class: Label  do
    name { "ファッション" }
  end
end