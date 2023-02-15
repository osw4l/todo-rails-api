class Todo < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true

  # this method removes fields from the response
  def as_json(options={})
    super(options.merge({ except: [:user_id, :created_at, :updated_at] }))
  end

  def complete!
    update(completed: true, completed_at: Time.zone.now)
  end
end
