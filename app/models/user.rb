class User < ActiveRecord::Base
  enum role: [:guest, :member, :admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :orders, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}

  mount_uploader :avatar, AvatarUploader

  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  after_initialize :update_role, if: :new_record?

  def update_role
    self.role = Settings.role.member
  end

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
      end
    end
  end
end
