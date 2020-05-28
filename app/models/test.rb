class Test < ApplicationRecord
  include RankedModel
  ranks :row_order

  belongs_to :project
  belongs_to :subject
  has_many :test_questions, dependent: :destroy
  has_many :testings, dependent: :destroy
  has_many :testing_users, through: :testings, source: :user

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
