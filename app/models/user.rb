class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable,
         :omniauth_providers => [:facebook]


  has_attached_file :image, :styles => { :medium =>     "300x300#", :thumb => "200x200#" }
  validates_attachment :image, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }       
  has_one :profile      

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        if auth.info.image.present?
          avatar_url = process_uri(auth.info.image)
          user.update_attribute(:image, URI.parse(avatar_url))
        end
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.skip_confirmation!
      end
  end  

  private

  def self.process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end     
end
