class Card < ActiveRecord::Base
  attr_accessible :use_case, :user#, :simple_property
  
  validates :user, presence: true
  validates :use_case, inclusion: ['personal','business']
  # validates :use_case, uniqueness: { scope: :user_id, message: 'should have one card per use case' }

  belongs_to :user
  has_many :simple_properties
  has_many :email_shares

  def props
    simple_properties
  end

  def display_name
    find = props.find_by_k('name')
    return find.v if find
    user.name
  end

  def status
    status = '{'
    self.simple_properties.each do |prop|
      status << " #{prop.k}:#{prop.v},"
    end
    status.slice!(-1)
    status << ' }'
  end

  def vcard email_share
    Vpim::Vcard::Maker.make2 do |maker|
      n = 0
      maker.add_name do |name|
        name.given = display_name
      end
      
      # iPhone update token
      # item2.URL;type=pref:www.facebook.com
      # item2.X-ABLabel:update me!
      # maker.add_my_own "item#{n+=1}.URL;type=pref:#{Rails.application.routes.url_helpers.check_share_url(email_share.token, :host => 'localhost:3000')}"
      # maker.add_my_own "item#{n}.X-ABLabel:update me!"

      # Non-iPhone update token
      maker.add_url Rails.application.routes.url_helpers.check_share_url(email_share.token, :host => 'localhost:3000')
      
      # Not supported on Android
      # maker.add_photo do |photo|
      #   photo.link = 'http://gravatar.com/avatar/b8d1c11580078fa050f97503470ef06f'
      # end
      
      props.each do |prop|
        case prop.k
        when 'email'
          maker.add_email(prop.v) { |e| e.location = 'main' }
        when 'phone_mobile'
          maker.add_tel(prop.v) { |t| t.location = 'mobile'; t.preferred = true }
        when 'phone_home'
          maker.add_tel(prop.v) { |t| t.location = 'home' }
        end
      end
    end
  end

  # maker.add_name do |name|
    # name.prefix = 'Dr.'
    # name.given = 'Joe'
    # name.family = 'Death'
  # end
  # maker.add_addr do |addr|
  #   addr.preferred = true
  #   addr.location = 'work'
  #   addr.street = '12 Last Row, 13th Section'
  #   addr.locality = 'City of Lost Children'
  #   addr.country = 'Cinema'
  # end
  # maker.add_addr do |addr|
  #   addr.location = [ 'home', 'zoo' ]
  #   addr.delivery = [ 'snail', 'stork', 'camel' ]
  #   addr.street = '12 Last Row, 13th Section'
  #   addr.locality = 'City of Lost Children'
  #   addr.country = 'Cinema'
  # end
  # maker.nickname = "The Good Doctor"
  # maker.birthday = Date.today
  # maker.add_photo do |photo|
  #   photo.link = 'http://example.com/image.png'
  # end
  # maker.add_photo do |photo|
  #   photo.image = "File.open('drdeath.jpg').read # a fake string, real data is too large :-)"
  #   photo.type = 'jpeg'
  # end
  # maker.add_tel('416 123 1111')
  # maker.add_tel('416 123 2222') { |t| t.location = 'home'; t.preferred = true }
  # maker.add_impp('joe') do |impp|
  #   impp.preferred = 'yes'
  #   impp.location = 'mobile'
  # end
  # maker.add_x_aim('example') do |xaim|
  #   xaim.location = 'row12'
  # end
  # maker.add_tel('416-123-3333') do |tel|
  #   tel.location = 'work'
  #   tel.capability = 'fax'
  # end
  # maker.add_email('drdeath@work.com') { |e| e.location = 'work' }
  # maker.add_email('drdeath@home.net') { |e| e.preferred = 'yes' }
end
