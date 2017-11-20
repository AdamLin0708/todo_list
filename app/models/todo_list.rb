class TodoList < ApplicationRecord
  mount_uploader :file_location, PhotoImageUploader  
  validates_presence_of :title, :due_date, :description

  def can_destroy?   
    !overdue?
  end

  private

  def overdue?
    due_date < Date.today
  end
end
