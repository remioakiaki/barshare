# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
  let(:other_user) { FactoryBot.create(:user, name: 'その他ユーザー') }
  let(:other_user_micropost) { FactoryBot.create(:micropost, user: other_user) }
  let(:like) { FactoryBot.create(:like, user: user, micropost: other_user_micropost) }

  it 'いいねが有効である' do
    expect(like).to be_valid
  end

  it 'いいね解除が有効であること' do
    like
    expect { like.destroy }.to change { Like.count }.by(-1)
  end
end
