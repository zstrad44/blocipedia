class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #:confirmable

  after_initialize :set_standard_role , :if => :new_record?

  has_many :wikis, dependent: :destroy

  before_save { self.email = email.downcase if email.present? }

  validates :password, presence: true, length: { minimum: 6 }, on: :create

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  enum role: [:standard, :premium, :admin]


  def change_user_role(new_role)
   update_attribute(:role, new_role)
  end

  def downgrade
   self.change_user_role(0)
  end

  private

  def set_standard_role
    self.role ||= :standard
  end
end
