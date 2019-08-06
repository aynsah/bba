class User < ApplicationRecord
  has_many :campaign_complaints, dependent: :destroy
  has_many :campaigns, dependent: :destroy
  has_many :doas, dependent: :destroy
  has_many :donations
  
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
  validates :password, presence: {message: "can't be blank"}, length: { minimum: 8, message: "too short" }
  validates :name, presence: {message: "can't be blank"}, length: {minimum: 6, message: "too short"}

  mount_uploader :photo, AvatarUploader
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      $pass = user.password
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.save
    end
  end
end
