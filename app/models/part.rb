class Part < ApplicationRecord
  include RankedModel
  ranks :row_order

  belongs_to :subject
  has_many :questions, dependent: :destroy
  has_many :achieveds, dependent: :destroy
  has_many :achieved_users, through: :achieveds, source: :user

  validates :title, :content, presence: true
  # id以外の要素でページネーションを実装
  def previous
    Part.where("row_order < ?", self.row_order).order("row_order DESC").first
  end
  def next
    Part.where("row_order > ?", self.row_order).order("row_order ASC").first
  end
end
