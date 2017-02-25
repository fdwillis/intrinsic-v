class Stock < ActiveRecord::Base
  has_many :logs
  validates_uniqueness_of :symbol
  accepts_nested_attributes_for :logs, reject_if: :all_blank, allow_destroy: true

  def self.intrinsic(log_id)
    @log = Log.find(log_id)

    bvci=bv_perc_change(@log.stock.symbol)

    parr=(@current_bv)*((1+bvci/100.to_f) ** 10)

    r = ENV['FED_NOTE'].to_f/100.to_f

    cx=@log.coupon*(1-(1/((1+r) ** 10)))/r+parr/((1+r) ** 10) 
  end

  protected

  def self.bv_perc_change(symbol)
    @current_bv=book_value(symbol)
    old_bv= @log.stock.old_bv
    years= @log.stock.bv_years
    upper=(1/years.to_f)
    base=(@current_bv/old_bv.to_f)
    a=base**upper
    100*(a-1)
  end

  def self.book_value(symbol)
    Stock.get_stock(symbol)
    return (@log.equity.to_d / @log.shares.to_d).round(2)
  end

  def self.eps(symbol)
    Stock.get_stock(symbol)
    return (@log.net_income.to_d / @log.shares.to_d).round(2)
  end

  def self.pe_ratio(symbol)
    Stock.get_stock(symbol)
    return (@log.price.to_f / Stock.eps(symbol) ).round(2)
  end

  def self.safety(symbol)
    Stock.get_stock(symbol)
    return (1.to_d / Stock.eps(symbol) ).round(2)
    
  end

  def self.get_stock(symbol)
    @stock = Stock.where(symbol: symbol).first
  end

end
