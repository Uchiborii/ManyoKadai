require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task)  {FactoryBot.create(:task, title: 'title')}
  let!(:task1) { FactoryBot.create(:task1) }
  let!(:task2) { FactoryBot.create(:task2) }
  before do
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        expect(page).to have_content 'title'
      end
    end
  end
    describe '一覧表示機能' do
      context '一覧画面に遷移した場合' do
        it '作成済みのタスク一覧が表示される' do
          # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
          # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
          expect(page).to have_content 'title'
          expect(page).to have_content 'title2'
          # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
        end
      end
      context 'タスクが作成日時の降順に並んでいる場合' do
        it '新しいタスクが一番上に表示される' do
          task_list = all('.task_row')
          expect(page.text).to match(/#{task2.title}[\s\S]*#{task.title}/)
        end
      end
    end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'title', content: 'task')
        visit task_path(task)
        expect(page).to have_content 'task'
      end
    end
  end
end