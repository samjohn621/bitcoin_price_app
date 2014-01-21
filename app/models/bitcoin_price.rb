class BitcoinPrice < ActiveRecord::Base

  acts_as_api

  api_accessible :price do |template|
    	
    mtgox = MtGox.ticker
    bitstamp = Bitstamp.ticker
    btce = Btce::Ticker.new "btc_usd"
    coinbase = Coinbase::Client.new("5d6e5a7891b129eea78841b5995be2c762883b14709b2cc2575f79f767e8ce24")

    # template.add  :mtgox_price, :as => :mp
    template.add  lambda {|model| self.mtgox_price(mtgox)}, :as => :mtgox
    template.add  lambda {|model| self.bitstamp_price(bitstamp)}, :as => :bitstamp
    template.add  lambda {|model| self.btce_price(btce)}, :as => :btce
    template.add  lambda {|model| self.coinbase_price(coinbase)}, :as => :coinbase
  end


  def self.mtgox_price(mtgox)
	  {	
	  	"low" => mtgox.low,
	  	"high" => mtgox.high,
	  	"current_price" => mtgox.price,
	  	"buy" => mtgox.buy,
	  	"sell" => mtgox.sell,
	  	"previous_price" => mtgox.previous_price,
	  	"volume" => mtgox.volume,
	  	"1_week_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "mtgoxUSD",  1.week.ago.strftime("%Y-%m-%d")).first.try(:close) || "N/A" ,
	  	"1_month_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "mtgoxUSD",  1.month.ago.strftime("%Y-%m-%d")).first.try(:close) || "N/A" ,
	  	"3_month_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "mtgoxUSD",  3.month.ago.strftime("%Y-%m-%d")).first.try(:close)  || "N/A",
	  	"1_year_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "mtgoxUSD",  1.year.ago.strftime("%Y-%m-%d")).first.try(:close)  || "N/A",
	  	"daily_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"weekly_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"monthly_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"3_month_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"1_year_chart_url" => "http://192.184.82.25/candlestick.png"
	  }	
  end	

  def self.bitstamp_price(bitstamp)
	  {	
	  	"low" => bitstamp.low,
	  	"high" => bitstamp.high,
	  	"current_price" => bitstamp.last,
	  	"buy" => bitstamp.ask,
	  	"sell" => bitstamp.bid,
	  	"volume" => bitstamp.volume,
	  	"1_week_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "bitstampUSD",  1.week.ago.strftime("%Y-%m-%d")).first.try(:close)  || "N/A",
	  	"1_month_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "bitstampUSD",  1.month.ago.strftime("%Y-%m-%d")).first.try(:close)  || "N/A",
	  	"3_month_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "bitstampUSD",  3.month.ago.strftime("%Y-%m-%d")).first.try(:close) || "N/A",
	  	"1_year_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "bitstampUSD",  1.year.ago.strftime("%Y-%m-%d")).first.try(:close) || "N/A",
	  	"daily_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"weekly_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"monthly_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"3_month_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"1_year_chart_url" => "http://192.184.82.25/candlestick.png"
	  }	
  end	


  def self.btce_price(btce)
	  {	
	  	"low" => btce.json["btc_usd"]["low"].to_s,
	  	"high" => btce.json["btc_usd"]["high"].to_s,
	  	"current_price" => btce.json["btc_usd"]["last"].to_s,
	  	"buy" => btce.json["btc_usd"]["buy"].to_s,
	  	"sell" => btce.json["btc_usd"]["sell"].to_s,
	  	"volume" => btce.json["btc_usd"]["vol_cur"].to_s,
	  	"1_week_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "btceUSD",  1.week.ago.strftime("%Y-%m-%d")).first.try(:close) || "N/A",
	  	"1_month_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "btceUSD",  1.month.ago.strftime("%Y-%m-%d")).first.try(:close) || "N/A",
	  	"3_month_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "btceUSD",  3.month.ago.strftime("%Y-%m-%d")).first.try(:close) || "N/A",
	  	"1_year_ago" => BitcoinHistoricPrice.where("exchange = ? AND DATE(price_at) = ?", "btceUSD",  1.year.ago.strftime("%Y-%m-%d")).first.try(:close)|| "N/A",
	  	"daily_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"weekly_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"monthly_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"3_month_chart_url" => "http://192.184.82.25/candlestick.png",
	  	"1_year_chart_url" => "http://192.184.82.25/candlestick.png"

	  }	
  end	

  def self.coinbase_price(coinbase)
    coinbase_buy = coinbase.buy_price(1).format
    coinbase_sell = coinbase.sell_price(1).format
	  {	
	  	"buy" => coinbase_buy,
	  	"sell" => coinbase_sell,
	  }	
  end


  def self.historic_price(exchange, linux_time, count=1)
  	ap exchange
  	ap linux_time
	conn = Faraday.new(:url => 'http://api.bitcoincharts.com/') do |faraday|
	  faraday.request  :url_encoded             # form-encode POST params
	  faraday.response :logger                  # log requests to STDOUT
	  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
	end
	# response = conn.get '/v1/trades.csv?symbol=btceUSD&start=1356998400' 
	response = conn.get "/v1/trades.csv?symbol=#{exchange}&start=#{linux_time}" 
	r = response.body
	require 'csv'

	a = CSV.parse(r)
	Time.at(a[0][1].to_i)
	a[0][1]
  end 		
  

end