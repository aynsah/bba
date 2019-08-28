class User < ApplicationRecord
  has_many :campaign_complaints, dependent: :destroy
  has_many :campaigns, dependent: :destroy
  has_many :doas, dependent: :destroy
  has_many :donations
  has_many :report_donations, dependent: :nullify
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  # validates :terms_of_service, acceptance: true

  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255, message: "too long" },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: {message: "can't be blank"}, on: :create
  validates :password, length: { minimum: 8, message: "too short" }, on: :create
  validates :name, presence: {message: "can't be blank"}, length: {minimum: 6, message: "too short"}, uniqueness: { message: "Username ini sudah dipakai" }

  mount_uploader :photo, AvatarUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      $pass = user.password
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      guest_number = 0
      while(User.where(:name => user.name).any?)
        user.name += "#{guest_number}"
        guest_number += 1
      end
      user.photo = auth.info.image
      user.save
    end
  end
end
