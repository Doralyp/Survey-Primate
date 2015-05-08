class CompletionChoice < ActiveRecord::Base
  belongs_to :completion
  belongs_to :choice

  validates :completion_id, presence: true
  validates :choice_id, presence: true
end
