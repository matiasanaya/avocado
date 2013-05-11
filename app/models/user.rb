class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  after_create :create_cards

  has_many :cards

  private

  def create_cards
    ['personal','business'].each do |type|
      c = Card.new(use_case: type)
      c.user = self
      c.save
    end
  end

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
