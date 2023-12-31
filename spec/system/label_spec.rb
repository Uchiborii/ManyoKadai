require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do

  def user_login
    visit new_session_path
    fill_in 'session[email]', with: 'kirin@gmail.com'
    fill_in 'session[password]', with: 'password123'
    click_button 'ログイン'
  end

  before do
    @user = FactoryBot.create(:user)
    user_login
  end

  let!(:label1) { FactoryBot.create(:label) }
  let!(:label2) { FactoryBot.create(:label1) }
  let!(:label3) { FactoryBot.create(:label2) }

  describe 'ラベル機能テスト' do
    context '新規作成画面でラベルを押した場合' do
      it '一覧画面でラベルが出力される' do
        visit new_task_path
        fill_in 'task_title',with: 'title'
        fill_in 'task_content',with: 'task'
        select '2023',from: 'task_limit_date_1i'
        select '5',from: 'task_limit_date_2i'
        select '22',from: 'task_limit_date_3i'
        select '着手中',from: 'task[status]'
        select '高',from: 'task[priority]'
        check '日用品'

        click_button '登録'
        task_label_lists = all('.task_label')
        expect(page).to have_content '日用品'
      end
    end

    context '編集でラベルを変更した場合' do
      before do
        visit new_task_path
        fill_in 'task_title',with: 'title'
        fill_in 'task_content',with: 'task'
        select '2023',from: 'task_limit_date_1i'
        select '5',from: 'task_limit_date_2i'
        select '22',from: 'task_limit_date_3i'
        select '着手中',from: 'task[status]'
        select '高',from: 'task[priority]'
        check '日用品'
        click_button '登録'
      end
      it '一覧画面で変更したラベルが出力される' do
        click_link '編集'

        check 'ファッション'
        click_button '登録'
        click_on '戻る'
        expect(page).to have_content '日用品'
      end
    end
  end
end
