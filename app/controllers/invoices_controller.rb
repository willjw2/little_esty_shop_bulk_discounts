class InvoicesController < ApplicationController
  before_action :find_invoice_and_merchant, only: [:show, :update]
  before_action :find_merchant, only: [:index]

  def index
    @invoices = @merchant.invoices
  end

  def show
    @customer = @invoice.customer
    # why is this line here if it does nothing?
    # @invoice_item = InvoiceItem.where(invoice_id: params[:id]).first
    @bulk_discount_amount = @invoice.bulk_discount_amount(@merchant.id)
    @discounted_revenue = @invoice.total_revenue - @bulk_discount_amount
    # try and refactor later
    # @bulk_discounts.sum {|ii| ii.max_discount}
  end

  def update
    @invoice.update(invoice_params)
    redirect_to merchant_invoice_path(@merchant, @invoice)
  end

  private
  def invoice_params
    params.require(:invoice).permit(:status)
  end

  def find_invoice_and_merchant
    @invoice = Invoice.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
