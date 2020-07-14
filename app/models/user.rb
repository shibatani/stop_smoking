class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ImageUploader

  validates :name, presence: true 
  validates :word, length: { maximum: 200 } 

  has_many :posts
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :comments
end
