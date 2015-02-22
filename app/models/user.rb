class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_permissions, :dependent => :destroy
  has_many :restrictables, :through => :user_permissions
  has_many :companies, :through => :user_permissions, :source => :restrictable, :source_type => 'Company'
  has_many :projects, :through => :user_permissions, :source => :restrictable, :source_type => 'Project'

  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false

  accepts_nested_attributes_for :companies
end
