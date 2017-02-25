class Stock < ActiveRecord::Base
  has_many :logs
  validates_uniqueness_of :symbol
  accepts_nested_attributes_for :logs, reject_if: :all_blank, allow_destroy: true

  def self.intrinsic(log_id)
    @log = Log.find(log_id)

    bvci=bv_perc_change(@log.stock.symbol)

    parr=(@current_bv)*((1+bvci/100.to_f) ** 10)

    r = 2.38/100.to_f

    cx=@log.coupon*(1-(1/((1+r) ** 10)))/r+parr/((1+r) ** 10) 
  end

  protected

  def self.bv_perc_change(symbol)
    @current_bv=book_value(nil,symbol)
    old_bv= @log.stock.old_bv
    years= @log.stock.bv_years
    upper=(1/years.to_f)
    base=(@current_bv/old_bv.to_f)
    a=base**upper
    100*(a-1)
  end

  def self.book_value(log_id, symbol)
    if log_id.present? && !symbol.present?
      @log = Log.find(log_id) 
      return (@log.equity.to_d / @log.shares.to_d).round(2)
    elsif !log_id.present? && symbol.present?
      @symbol = Stock.find_by(symbol: symbol) 
      return (@symbol.logs.map(&:equity).sum.to_d / @symbol.logs.map(&:shares).sum.to_d).round(2)
    end
  end

  def self.eps(log_id, symbol)
    if log_id.present? && !symbol.present?
      @log = Log.find(log_id) 
      return (@log.net_income.to_d / @log.shares.to_d).round(2)
    end
  end

  def self.pe_ratio(log_id, symbol)
    if log_id.present? && !symbol.present?
      @log = Log.find(log_id) 
      return (@log.price.to_f / Stock.eps(log_id, nil) ).round(2)      
    end
  end

  def self.safety(log_id, symbol)
    if log_id.present? && !symbol.present?
      Stock.get_stock(log_id)
      return (1.to_d / Stock.eps(log_id, nil) ).round(2)
    end
  end

  def self.get_stock(symbol)
    @stock = Stock.where(symbol: symbol).first
  end

end
