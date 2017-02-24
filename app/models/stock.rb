class Stock < ActiveRecord::Base
  has_many :logs
  validates_uniqueness_of :symbol
  accepts_nested_attributes_for :logs, reject_if: :all_blank, allow_destroy: true

  def self.intrinsic(symbol)
    # @stockx = Stock.find_by(symbol: symbol)

    # bvci=bv_perc_change(@stockx.symbol)

    # parr=(@current_bv)*((1+bvci/100.to_f) ** 10)

    # r = ENV['FED_NOTE'].to_f/100.to_f

    # cx=@stockx.coupon*(1-(1/((1+r) ** 10)))/r+parr/((1+r) ** 10) 

    100
  end

  protected

  def self.bv_perc_change(symbol)
    @current_bv=book_value(symbol)
    old_bv= @stockx.old_bv
    years= @stockx.bv_years
    upper=(1/years.to_f)
    base=(@current_bv/old_bv.to_f)
    a=base**upper
    100*(a-1)
  end

  def self.book_value(symbol)
    Stock.get_stock(symbol)
    return (@stock.equity.to_d / @stock.shares.to_d).round(2)
  end

  def self.eps(symbol)
    Stock.get_stock(symbol)
    return (@stock.net_income.to_d / @stock.shares.to_d).round(2)
  end

  def self.pe_ratio(symbol)
    Stock.get_stock(symbol)
    return (@stock.price.to_f / Stock.eps(symbol) ).round(2)
  end

  def self.safety(symbol)
    Stock.get_stock(symbol)
    return (1.to_d / Stock.eps(symbol) ).round(2)
    
  end

  def self.get_stock(symbol)
    @stock = Stock.where(symbol: symbol).first
  end

end
