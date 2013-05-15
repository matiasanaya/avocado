class SimpleProperty < ActiveRecord::Base
  attr_accessible :k, :v
  validates :k, presence: true
  validates :v, presence: true
  validates :card, presence: true

  belongs_to :card

  ICONS = { name: 'user', phone_mobile: 'mobile-phone', phone_home: 'phone', email: 'envelope-alt', facebook: 'facebook' }

  def icon
    ICONS[k.to_sym] || 'question-sign' 
  end
end
