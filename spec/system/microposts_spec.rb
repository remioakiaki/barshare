# frozen_string_literal: true

require 'rails_helper'

describe '投稿機能' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:micropost) { FactoryBot.create(:micropost, user: user, title: '鳥貴族') }

  describe '投稿作成機能' do
    context 'ログイン時' do
      before do
        sign_in_as user
      end
      it '投稿ができること' do
        visit root_path
        expect do
          fill_in 'micropost[content]', with: 'テスト投稿'
          click_on '投稿'
        end.to change { Micropost.count }.by(1)
        expect(page).to have_content '投稿が完了しました'
      end
      it '入力がないとエラーになること' do
        visit root_path

        fill_in 'micropost[content]', with: ''
        click_button '投稿'
        expect(page).to have_content '投稿内容を入力してください'
      end
    end
  end
  describe '投稿編集機能' do
    context 'ログイン時' do
      before do
        sign_in_as user
      end
      it '編集ができること' do
        visit root_path
        find(".micropost_edit_#{micropost.id}").click
        sleep 1.0

        find('.edit-area').set('テスト編集')
        click_on '更新'

        expect(page).to have_content '編集が完了しました'
      end
      it '入力がないとエラーになること' do
        visit root_path
        find(".micropost_edit_#{micropost.id}").click
        sleep 1.0

        find('.edit-area').set('')
        click_on '更新'

        expect(page).to have_content '投稿内容を入力してください'
      end
    end
    context '非ログイン時' do
      it '編集不可' do
        visit edit_micropost_path(micropost)
        expect(page).to have_content 'ログインしてください'
      end
    end
  end
  describe '投稿削除機能' do
    context 'ログイン時' do
      before do
        sign_in_as user
      end
      it '削除ができる' do
        visit root_path
        expect do
          find(".micropost_delete_#{micropost.id}").click
        end.to change(Micropost, :count).by(-1)
        expect(page).to have_content('投稿を削除しました')
      end
    end
  end
  describe '投稿からお店検索機能' do
    context 'ログイン時' do
      before do
        sign_in_as user
      end
      it '検索ボタンを押して、ページの移行ができる' do
        visit root_path
        find(".micropost_search_#{micropost.id}").click
        expect(page).to have_content('営業時間')
      end
    end
  end
end
