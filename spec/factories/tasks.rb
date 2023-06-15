FactoryBot.define do
  factory :task do
    title { 'title' }
    content { 'task' }
  end

  FactoryBot.define do
    factory :task1, class: Task do
      title { 'title1' }
      content { 'task1' }
    end

    factory :task2, class: Task do
      title { 'title2' }
      content { 'task2' }
    end
  end

end
