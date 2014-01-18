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
	  	"volume" => mtgox.volume
	  }	
  end	

  def self.bitstamp_price(bitstamp)
	  {	
	  	"low" => bitstamp.low,
	  	"high" => bitstamp.high,
	  	"current_price" => bitstamp.last,
	  	"buy" => bitstamp.ask,
	  	"sell" => bitstamp.bid,
	  	"volume" => bitstamp.volume
	  }	
  end	


  def self.btce_price(btce)
	  {	
	  	"low" => btce.json["btc_usd"]["low"].to_s,
	  	"high" => btce.json["btc_usd"]["high"].to_s,
	  	"current_price" => btce.json["btc_usd"]["last"].to_s,
	  	"buy" => btce.json["btc_usd"]["buy"].to_s,
	  	"sell" => btce.json["btc_usd"]["sell"].to_s,
	  	"volume" => btce.json["btc_usd"]["vol_cur"].to_s
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
  

end