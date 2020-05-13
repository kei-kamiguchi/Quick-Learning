class AdminChoiceCategory < ApplicationRecord
  belongs_to :admin
  belongs_to :category
end
