class Goal < ActiveRecord::Base
  attr_accessible :name, :user_id, :goal_type, :status

  validates :name, :user_id, :goal_type, :presence => true

  before_save :set_default

  belongs_to :user

  def set_default
    self.status ||= "INCOMPLETE"
  end
end
