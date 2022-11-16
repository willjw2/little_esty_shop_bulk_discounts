class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  #add model test for this relationship later
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    # require "pry"; binding.pry
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end
  
  def discount_applied
    # require "pry"; binding.pry
    bulk_discounts
    .where('? >= bulk_discounts.quantity', self.quantity)
    .order('percentage DESC')
    .first

    # .where('bulk_discounts.quantity <= invoice_items.quantity')
  end
end
