class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  after_initialize(:set_default_private, {if: :new_record?})

    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :user, presence: true
    # validates :user, presence: true

  # scope :visible_to, -> (user){user ? where("private is null or private=? or user_id=?",false, user.id).uniq : where(private:false)}
  # scope :public_wikis, -> {where(private:false)}
  # scope :private_wikis, -> {where(private:true)}
  # scope :my_wikis, -> (user){where(user_id:user)}

  # default_scope {order('lower(title)')}
  default_scope { order(updated_at: :desc) }

  def set_default_private
    self.private ||= false
  end

  def set_as_public
    self.update_attribute(:private, false)
  end

  def public?

    !self.private

  end
end
