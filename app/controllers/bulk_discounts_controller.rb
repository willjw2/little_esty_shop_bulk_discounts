class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
    @holidays = HolidaySearch.new.holiday_info.upcoming_holidays
    # require "pry"; binding.pry
  end
  def show
    @merchant = Merchant.find(params[:merchant_id])
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
      flash.notice = "Bulk Discount not created: Required information missing."
      redirect_to new_merchant_bulk_discount_path(@merchant)
    end
  end
  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(merchant)
  end
  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end
  def update
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    if bulk_discount.update(bulk_discount_params)
      flash.notice = 'Bulk Discount updated successfully!'
      redirect_to merchant_bulk_discount_path(merchant, bulk_discount)
    else
      flash.notice = "Bulk Discount not updated: Required information missing."
      redirect_to edit_merchant_bulk_discount_path(merchant, bulk_discount)
    end
  end

  private

  def bulk_discount_params
    params.permit(:percentage, :quantity, :merchant_id)
  end
end
