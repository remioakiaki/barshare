require 'rails_helper'

describe 'Homeへのテスト' do
  it '画面の表示' do
    visit '/static_pages/home'
    expect(page).to have_content(text: '投稿')
  end
end


