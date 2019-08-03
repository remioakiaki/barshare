require 'rails_helper'

describe 'Homeへのテスト' do
  it '画面の表示' do
    visit '/static_pages/home'
    expect(page).to have_css('h1', text: 'StaticPages#home')
  end
end

describe 'Rootへのテスト' do
  it '画面の表示' do
    visit root_path
    expect(page).to have_css('h1', text: 'StaticPages#home')
  end
end