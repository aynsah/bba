class User < ApplicationRecord
  has_many :campaign_complaints
  has_many :campaigns, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  # validates :terms_of_service, acceptance: true

  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }

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
  RailsAdmin.config do |config|
    config.model 'User' do
      navigation_icon 'icon-user'
      label "Users"
    end
  end

end
