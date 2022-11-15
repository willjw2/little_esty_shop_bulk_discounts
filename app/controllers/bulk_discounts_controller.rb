class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end
  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
  def create
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.new(bulk_discount_params)
    # require "pry"; binding.pry
    if bulk_discount.save
      redirect_to "/merchant/#{@merchant.id}/bulk_discounts"
    else
      flash[:notice] = "Bulk Discount not created: Required information missing."
      render :new
    end
  end


  private

  def bulk_discount_params
    params.permit(:percentage, :quantity, :merchant_id)
  end
end
