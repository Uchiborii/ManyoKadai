require 'rails_helper'

RSpec.describe 'タスクモデル機能', type: :model do

  before do
    @task = FactoryBot.create(:task, title: 'task')
    @task1 = FactoryBot.create(:task1, title:'task1')
    @task2 = FactoryBot.create(:task2,title: 'task2')
  end

  describe '検索機能' do
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.get_by_title('task')).to include(@task)
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.get_by_status('完了')).to include(@task1)
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.get_by_title('task2').get_by_status('完了')).to include(@task2)
      end
    end
  end

    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションに引っ掛かる' do
          task = Task.new(title: '', content: '失敗テスト')
          expect(task).not_to be_valid
        end
      end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト', limit_date: Date.today)
        expect(task).to be_valid
      end
    end
  end
end