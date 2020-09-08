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
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.days = 1
      user.boxes = 1
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  CIGARETTE_PRICE = 500
  NUMBER_OF_CIGARETTES = 20
  EXTENDED_LIFESPAN_CONSTANT = 5

  def continue_days
    created_date = self.created_at.to_date 
    today = Date.current 
    continue_days = (today - created_date).to_i 
    return continue_days
  end

  def frequency(continue_days)
    frequency = continue_days / self.days
    return frequency
  end 

  def saved_money(frequency) 
    saved_money = self.boxes * CIGARETTE_PRICE * frequency
    return saved_money
  end

  def cigarettes(frequency)
    cigarettes = self.boxes * NUMBER_OF_CIGARETTES * frequency
    return cigarettes
  end

  def lifespan(cigarettes)
    lifespan = cigarettes * EXTENDED_LIFESPAN_CONSTANT
    return lifespan
  end
end
