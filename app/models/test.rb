class Test < ApplicationRecord
  belongs_to :project
  belongs_to :subject
  has_many :test_questions, dependent: :destroy
  validates :title, :active, presence: true
  enum active: { deactive: 0, active: 1 }
  validates :active, inclusion: { in: Test.actives.keys }

  def toggle_active!
    if deactive?
      active!
    else
      deactive!
    end
  end
end
