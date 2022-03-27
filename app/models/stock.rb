# somehow allow value to be shown for any specific range of time

class Stock < ActiveRecord::Base
  has_many :logs
  validates_uniqueness_of :symbol
  accepts_nested_attributes_for :logs, reject_if: :all_blank, allow_destroy: true

  def intrinsic
    get_stock

    bvci=bv_perc_change

    parr=(@current_bv)*((1+bvci/100.to_f) ** 10)

    r = 2.38/100.to_f

    # last or first coupon by database entry?
    cx=@stock&.logs.present? ? (@stock&.logs&.last&.coupon).to_d*(1-(1/((1+r) ** 10)))/r+parr/((1+r) ** 10) : :needMoreData
  end

  protected

  def bv_perc_change
    @current_bv=book_value
    old_bv= @stock.old_bv
    years= @stock.bv_years
    upper=(1/years.to_f)
    base=(@current_bv/old_bv.to_f)
    a=base**upper
    100*(a-1)
  end


  def book_value
    get_stock  
    return (@stock.logs.map(&:equity).sum.to_d / @stock.logs.map(&:shares).sum.to_d).round(2)
  end

  def eps
    get_stock  
    return (@stock.logs.map(&:net_income).sum.to_d / @stock.logs.map(&:shares).sum.to_d).round(2)
  end

  def pe_ratio
    get_stock  
    # for every P/E dollars i spend i should receive 1 dollar a year later
    return (@stock.logs.map(&:price).sum.to_f / eps ).round(2)      
  end

  def safety(ask)
    get_stock  
    return (ask.to_d / eps ).round(2)
  end

  def get_stock
    @stock = Stock.find_by(symbol: symbol)
  end

end



=begin

debt to equity < .50 (all debt compared to equity)
current assets / current liabilities > 1.50 (debt in the next 12 months)
  

use projected earnings and eps (gem) for prediction of next set of individual/corporate data
Future projections should be visible but inactive - greyed out with the ability to only view. limited clicking and interaction for more detail)


countdown to the next snapshot to gamify account balances

=end