User.create!(name:  "テストの人",
            email: "test@gmail.com",
            password:  "123456",
            )

Label.destroy_all
labels = [
  { name: "日用品" },
  { name: "娯楽" },
  { name: "ファッション" },
]
labels.each do |label_params|
  Label.create!(label_params)
end