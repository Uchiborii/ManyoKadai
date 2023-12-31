require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  def user_login
    visit new_session_path
    fill_in 'session[email]', with: 'sample@example.com'
    fill_in 'session[password]', with: '00000000'
    click_button 'ログイン'
  end
  before do
    @user = FactoryBot.create(:user)
    @admin_user = FactoryBot.create(:admin_user)
    user_login
  end

  let!(:task)  {FactoryBot.create(:task, title: 'title', limit_date: '2023-05-22')}
  let!(:task1) { FactoryBot.create(:task1, title: 'title1', limit_date:'2024-05-22') }
  let!(:task2) { FactoryBot.create(:task2, title: 'title2', limit_date:'2025-05-22') }
  before do
    visit tasks_path
  end
  describe '優先順位での並び変え' do
    context '優先順位をソートするボタンを押した場合' do
      it '優先順位の昇順で表示される' do
        click_on '優先順位をソートする'
        sleep(1)
        task_list = all('.priority_high')
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '中'
      end
    end
  end
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'タイトル検索',with: 'title'
        click_on '検索'
        expect(page).to have_content 'title'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '完了',from: 'ステータス検索'
        expect(page).to have_select('ステータス検索', selected: '完了')
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'タイトル検索',with: 'title'
        select '完了',from: 'ステータス検索'
        click_on '検索'
        expect(page).to have_content 'title'
        expect(page).to have_select('ステータス検索', selected: '完了')
      end
    end
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_title',with: 'title'
        fill_in 'task_content',with: 'task'
        select '2023',from: 'task_limit_date_1i'
        select '5',from: 'task_limit_date_2i'
        select '22',from: 'task_limit_date_3i'
        select '着手中',from: 'task[status]'
        select '高',from: 'task[priority]'
        click_button '登録'
        expect(page).to have_content 'title'
        expect(page).to have_content 'task'
        expect(page).to have_content '2023-05-22'
        expect(page).to have_content '着手中'
        expect(page).to have_content '高'
      end
    end
    context '終了期限でソートするボタンを押した場合' do
      it '終了期限の降順で表示される' do
        visit tasks_path
        click_on '終了期限でソートする'
        sleep(1)
        task_list = all('.task_limit')
        expect(task_list[0]).to have_content '2025-05-22'
        expect(task_list[1]).to have_content '2024-05-22'
        expect(task_list[2]).to have_content '2023-05-22'
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