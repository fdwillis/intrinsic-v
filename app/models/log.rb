class Log < ActiveRecord::Base
  belongs_to :stock

  # def intrinsic(log_id)
  #   @log = Log.find(log_id)

  #   bvci=bv_perc_change(@log.stock.symbol)

  #   parr=(@current_bv)*((1+bvci/100.to_f) ** 10)

  #   r = 2.38/100.to_f

  #   cx=@log.coupon*(1-(1/((1+r) ** 10)))/r+parr/((1+r) ** 10) 
  # end

  protected

  # def bv_perc_change(symbol)
  #   @current_bv=book_value(nil)
  #   old_bv= @log.stock.old_bv
  #   years= @log.stock.bv_years
  #   upper=(1/years.to_f)
  #   base=(@current_bv/old_bv.to_f)
  #   a=base**upper
  #   100*(a-1)
  # end


  def book_value
    return (equity.to_d / shares.to_d).round(2)
  end

  def eps
    return (net_income.to_d / shares.to_d).round(2)
  end

  def pe_ratio
    # for every P/E dollars i spend i should receive 1 dollar a year later
    return (price.to_f / eps ).round(2)      
  end
end
