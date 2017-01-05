class Wiki < ActiveRecord::Base
  belongs_to :user

  # default_scope { order('rank DESC') }

  scope :visible_to, -> (user) { user ? all : joins(:wiki).where('wikis.public' => true) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  # validates :user, presence: true

end
