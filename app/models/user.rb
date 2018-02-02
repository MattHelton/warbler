class User < ApplicationRecord
  serialize :following, Array
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
# associations
  has_many :tweets

  mount_uploader :avatar, AvatarUploader
  # validations
  validates :username, presence: true
  validates :username, uniqueness: true
  validates_presence_of   :avatar
  validates_integrity_of  :avatar
  validates_processing_of :avatar
end
