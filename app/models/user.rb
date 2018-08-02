class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :login
  field :password_digest

  has_secure_password

  embeds_many :images

  validates :login, presence: true, length: { maximum: 25 }
  validates :password, length: { minimum: 6 }, allow_nil: true
end
