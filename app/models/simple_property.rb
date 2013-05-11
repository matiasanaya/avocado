class SimpleProperty < ActiveRecord::Base
  attr_accessible :k, :v
  validates :k, presence: true
  validates :v, presence: true
  validates :card, presence: true

  belongs_to :card
end
