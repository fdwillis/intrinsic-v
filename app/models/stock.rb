class Stock < ActiveRecord::Base
  has_many :logs


  protected

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
