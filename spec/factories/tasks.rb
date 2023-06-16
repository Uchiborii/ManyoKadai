FactoryBot.define do
  factory :task do
    title { 'title' }
    content { 'task' }
    limit_date { '2023-05-22' }
    priority { '高' }
    status { '完了' }
  end

  factory :task1, class: Task do
    title { 'title1' }
    content { 'task1' }
    limit_date { '2024-05-22' }
    priority { '中' }
    status { '完了' }
    end

  factory :task2, class: Task do
    title { 'title2' }
    content { 'task2' }
    limit_date { '2025-05-22' }
    priority { '低' }
    status { '完了' }
  end
end
