class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :subtitle
  validates :subtitle, invisible_captcha: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  devise :omniauthable, omniauth_providers: [:facebook]
  has_many :periods

  def remember_me
    (super == nil) ? '1' : super
  end

  # Creates or updates a user with Facebook credentials
  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      return_user = self.where(email: auth.info.email).first
    else
      return_user = self.create do |user|
        user.password = Devise.friendly_token[0, 20]
        user.email = auth.info.email
        user.skip_confirmation!
      end
    end
    return_user.provider = auth.provider
    return_user.uid = auth.uid
    return_user.name = auth.info.name

    return_user
  end
end
