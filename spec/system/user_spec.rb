require 'rails_helper'
RSpec.describe '【ユーザー登録・ログイン・管理ユーザー画面に関するテスト】' type :system do
  def user_login
    visit new_session_path
    fill_in 'session[email]', with: 'kirin@gmail.com'
    fill_in 'session[password]', with: '123456'
    check_button 'ログイン'
  end

  def admin_user_login
    visit new_session_path
    fill_in 'session[email]', with: 'admin@gmail.com'
    fill_in 'session[password]', with: '123456'
    check_button 'ログイン'
  end

  describe'ユーザー登録テスト' do
    context 'ユーザーのデータが無くログインしていない状態' do
      it 'ユーザーの新規登録テスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'kirin'
        fill_in 'user[email]', with: 'kirin@gmail.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_on '登録'
        click_link 'マイページ'
        expect(page).to have_content 'kirin'
      end
        it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit root_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能テスト' do
    before do
      @user = FactoryBot.create(:user)
      user_login
    end

    context 'ログインしていない状態でユーザーのデータがある場合' do
      it 'ログインができること' do
      expect(current_path).to eq root_path
    end
  end

    context '一般ユーザーでログインしている状態' do
      it '自分のマイページに飛べること' do
        click_link 'マイページ'
        expect(current_path).to eq user_path(1)
      end

      it '一般ユーザーが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        visit user_path(2)
        expect(current_path).to eq root_path
      end

      it 'ログアウトができること' do
        click_link 'ログアウト'
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq new_session_path
      end
    end
  end

    describe '管理画面テスト' do
      before do
        @user = FactoryBot.create(:user)
        @admin_user = FactoryBot.create(:admin_user)
      end

      context '一般ユーザーでログインしている状態' do
        it '一般ユーザーは管理画面にアクセスできないこと' do
          user_login
          visit admin_users_path
          expect(current_path).to eq root_path
        end
      end

      context '管理者でログインしている状態' do
        before do
          admin_user_login
          click_link '管理'
        end

        it '管理者は管理画面にアクセスできること' do
          expect(current_path).to eq admin_user_path
        end

      it '管理者はユーザーを新規登録できること' do
        click_link 'ユーザー登録'
        fill_in 'user[name]', with: 'kirin'
        fill_in 'user[email]', with: 'kirin@gmail.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_on 'アカウント登録'

        visit admin_users_path
        expect(page).to have_content 'kirin'
      end

      it '管理者はユーザーの詳細画面にアクセスできること' do
        sleep 1
        click_link 'kirin'
        expect(current_path).to eq user_path(1)
      end

      it '管理者はユーザの編集画面からユーザを編集できること' do
        sleep 1
        click_link '編集・削除', href: edit_admin_user_path(1)

        fill_in 'user[name]', with: 'kirin_after'
        click_button '登録'

        expect(page).to have_content 'kirin_after'
      end

      it '管理者はユーザの削除をできること' do
        sleep 1
        click_link '編集・削除', href: edit_admin_user_path(1)

        click_link 'ユーザーデータを削除する'
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content 'kirinさんのユーザーデータを削除しました'
      end
    end
  end
end