class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :subtitle
  validates :subtitle, invisible_captcha: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook]
  has_many :periods

  def remember_me
    (super == nil) ? '1' : super
  end

  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      return_user = self.where(email: auth.info.email).first
      return_user.provider = auth.provider
      return_user.uid = auth.uid
      return_user.name = auth.info.name
    else
      return_user = self.create do |user|
         user.provider = auth.provider
         user.uid = auth.uid
         user.name = auth.info.name
         user.username = auth.info.username
         user.email = auth.info.email
         user.oauth_token = auth.credentials.token
         user.oauth_expires_at = Time.at(auth.credentials.expires_at) 
      end
    end

  return_user
  end
end
