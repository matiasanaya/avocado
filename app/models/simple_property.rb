class SimpleProperty < ActiveRecord::Base
  attr_accessible :k, :v, :card_id
  validates :k, presence: true
  validates :v, presence: true
  validates :card, presence: true

  belongs_to :card

  ICONS = { name: 'user', phone_mobile: 'mobile-phone', phone_home: 'phone', email: 'envelope-alt', facebook: 'facebook', github: 'github', twitter: 'twitter' }
  HUMAN_KEYS = { phone_mobile: 'mobile', phone_home: 'home' }

  def human_key
    HUMAN_KEYS[k.to_sym] || k
  end

  def icon
    ICONS[k.to_sym] || 'question-sign' 
  end
end
