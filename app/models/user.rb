class User < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { in: 2..20 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :profile_image
end
