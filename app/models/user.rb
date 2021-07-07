class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ImageUploader

  attr_accessor :x, :y, :width, :height
  has_one_attached :image

  validates :name, presence: true 
  validates :word, length: { maximum: 200 } 
  validates :days, :numericality => { :greater_than => 0 } 
  validates :boxes, :numericality => { :greater_than => 0 } 

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

  def caluculate_days(lifespan)
    if lifespan >= 1440 
      days = lifespan / 1440
      return days
    end
  end

  def caluculate_remain(lifespan, days)
    if lifespan >= 1440 
      remain = lifespan - (1440 * days) 
    else
      return remain
    end
  end

  def caluculate_hours(lifespan, remain)
    if lifespan >= 1440
      hours = remain / 60
    elsif lifespan >= 60
      hours = lifespan / 60
    end
    return hours
  end

  def caluculate_minutes(lifespan, remain)
    if lifespan >= 1440
      minutes = remain % 60
    elsif lifespan >= 60
      minutes = lifespan % 60
    end
    return minutes
  end
end
