# frozen_string_literal: true

class Micropost < ApplicationRecord
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :pictures, length: { maximum: 4,
                                 too_long: 'は%{count}枚以内で入力してください' }
  belongs_to :user
  default_scope -> { order(updated_at: :desc) }

  mount_uploaders :pictures, PictureUploader
  # serialize :pictures, JSON
  validate :picture_size

  has_many :likes, foreign_key: 'micropost_id', dependent: :destroy
  has_many :users, through: :likes

  has_many :comments, dependent: :destroy

  private

  # アップロード画像のサイズを検証する
  def picture_size
    errors.add(:picture, 'should be less than 5MB') if pictures.size > 5.megabytes
  end
end
