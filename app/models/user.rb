class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,presence: true
  validates :nickname,presence: true, length: { in: 2..20 }

  has_many :blogs,dependent: :destroy
end
