class Wiki < ActiveRecord::Base
  belongs_to :user

  after_initialize(:set_default_private, {if: :new_record?})

    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :user, presence: true
    # validates :user, presence: true

  # default_scope { order('rank DESC') }

  # scope :visible_to, -> (user) { user ? all : joins(:wiki).where('wikis.public' => true) }

  scope :visible_to, -> (user){user ? where("private is null or private=? or user_id=?",false, user.id).uniq : where(private:false)}

  # default_scope {order('lower(title)')}
  default_scope { order(updated_at: :desc) }

  def set_default_private
    self.private ||= false
  end

  def set_as_public
    self.update_attribute(:private, false)
  end
end
