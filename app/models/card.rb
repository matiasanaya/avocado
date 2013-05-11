class Card < ActiveRecord::Base
  attr_accessible :use_case, :user#, :simple_property
  
  validates :user, presence: true
  validates :use_case, inclusion: ['personal','business']
  # validates :use_case, uniqueness: { scope: :user_id, message: 'should have one card per use case' }

  belongs_to :user
  has_many :simple_properties

  def status
    status = '{'
    self.simple_properties.each do |prop|
      status << " #{prop.k}:#{prop.v},"
    end
    status.slice!(-1)
    status << ' }'
  end
end
