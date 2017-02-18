namespace :grab do
  task stocks: :environment do

    alph = ('A'..'B').to_a

    alph.each do |a|

      d = Wombat.crawl do

        base_url "http://eoddata.com"

        # path "/stocklist/NYSE/#{a}.html"
        path "/stocklist/NASDAQ/#{a}.html"

        tickers({xpath: "//*[@class='ro']/td/a/text()"}, :list)
      end
      
      d["tickers"].each do |s|

        stock = StockQuote::Stock.quote(s)

        it = Stock.where(symbol: s).first_or_create
        it.update_attributes(
          symbol: s,
          volume: stock.volume,
          ave_volume: stock.average_daily_volume,
          mrkt_price: stock.ask,
        )
      end
    end
  end
end

# update just DB periodically
namespace :update do
  task stocks: :environment do
    Stock.all.each do |s|
      stock = StockQuote::Stock.quote(s.symbol)

      s.finas.create(
        eps: stock.earnings_share,
        pe_ratio: stock.pe_ratio,
        book_value: stock.book_value,
      )
      
      s.update_attributes(
        safety: stock.book_value / stock.ask,
      )
    end
  end
end

# send email of top picks(people can pay to get emails)
