class BulkDiscount < ApplicationRecord
  validates :percentage, presence: true, numericality: { less_than: 1, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true }

  belongs_to :merchant
end
