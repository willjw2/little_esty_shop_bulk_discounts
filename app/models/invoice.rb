class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  # has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, :'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def bulk_discount_amount(merchant_id)
    # require "pry"; binding.pry
    # invoice_items
    # .joins(item: :bulk_discounts)
    # .where('items.merchant_id = ?', merchant_id)
    # .where('invoice_items.quantity >= bulk_discounts.quantity')
    # .select('invoice_items.*, (max(bulk_discounts.percentage) * invoice_items.unit_price * invoice_items.quantity) as max_discount')
    # .group('invoice_items.item_id')
    # # .sum(:max_discount)

    invoice_items
    .joins(:bulk_discounts)
    .where('items.merchant_id = ?', merchant_id)
    .where('invoice_items.quantity >= bulk_discounts.quantity')
    .group('invoice_items.item_id')
    .maximum('invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage')
    .pluck(1)
    .sum
  end

  def admin_bulk_discount_amount
    invoice_items
    .joins(:bulk_discounts)
    .where('invoice_items.quantity >= bulk_discounts.quantity')
    .group('invoice_items.item_id')
    .maximum('invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage')
    .pluck(1)
    .sum
  end
end
