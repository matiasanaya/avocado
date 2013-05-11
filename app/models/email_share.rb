class EmailShare < ActiveRecord::Base
  attr_accessible :email
  before_create :set_status_and_token

  belongs_to :card

  validates :email, presence: true
  validates :card, presence: true

  def update
    self.status = 'Invalid'
    self.save
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
