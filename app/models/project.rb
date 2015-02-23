class Project < ActiveRecord::Base
  belongs_to :company
  has_many :user_permissions, :dependent => :destroy, :as => :restrictable
  has_many :users, :through => :user_permissions
  has_many :optimizable_classes, :dependent => :destroy
  has_many :optimizables, :through => :optimizable_classes
  has_many :optimizable_variants, :through => :optimizables

  validates_uniqueness_of :name, :scope => :company_id, :case_sensitive => false
  validates_uniqueness_of :subdomain, :api_key
  validates_presence_of :name, :subdomain

  before_create :generate_api_key

  private
  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end
end
