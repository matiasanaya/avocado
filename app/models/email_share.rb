class EmailShare < ActiveRecord::Base
  attr_accessible :email, :card_id
  before_create :set_status_and_token

  belongs_to :card

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :card, presence: true

  def update
    new_share = EmailShare.new email: self.email
    new_share.card = self.card
    new_share.save
  end

  def email_card
    CardMailer.shared_card(self).deliver
  end

  private

  def set_status_and_token
    if card
	  	self.status = self.card.status
		  begin
	      self.token = SecureRandom.urlsafe_base64
		  end while self.class.exists?(token: token)
    end
  end
end
