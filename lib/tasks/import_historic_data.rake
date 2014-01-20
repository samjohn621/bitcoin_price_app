
namespace :import do
desc "Import Historic Data"

  task :historic_mtgox_data => :environment do
    puts "Started Import Historic Data mtgoxUSD"
    # BitcoinHistoricPrice.destroy_all
    begin
      file = Rails.root.join('doc', 'historic_mtgox_data.txt')
      text = File.read(file)
      rows =    text.split("],")

      rows.each do |row|
        items = row.split(",")
        date_time = Time.at(items[0].gsub("[", "").to_i)
        open = items[1]
        high = items[2]
        low = items[3]
        close = items[4]
        volume_btc= items[5]
        volume_currency = items[6]
        avg_price = items[7]
        exchange = "mtgoxUSD"

        bhp = BitcoinHistoricPrice.new(
          price_at: date_time, 
          open: open, 
          close: close, 
          high: high, 
          low: low, 
          volume_btc: volume_currency, 
          volume_currency: volume_currency,
          avg_price: avg_price, 
          exchange: exchange          
        ) 
        bhp.save
    end
    rescue Exception => e
      puts e.backtrace
    end
  end


  task :historic_btce_data => :environment do
    puts "Started Import Historic Data btceUSD"

    begin
      file = Rails.root.join('doc', 'historic_btce_data.txt')
      text = File.read(file)
      rows =    text.split("],")

      rows.each do |row|
        items = row.split(",")
        date_time = Time.at(items[0].gsub("[", "").to_i)
        open = items[1]
        high = items[2]
        low = items[3]
        close = items[4]
        volume_btc= items[5]
        volume_currency = items[6]
        avg_price = items[7]
        exchange = "btceUSD"
        # BitcoinHistoricPrice.destroy_all
        bhp = BitcoinHistoricPrice.new(
          price_at: date_time, 
          open: open, 
          close: close, 
          high: high, 
          low: low, 
          volume_btc: volume_currency, 
          volume_currency: volume_currency,
          avg_price: avg_price, 
          exchange: exchange          
        ) 
        bhp.save
    end
    rescue Exception => e
      puts e.backtrace
    end
  end


  task :historic_bitstamp_data => :environment do
    puts "Started Import Historic Data bitstampUSD"

    begin
      file = Rails.root.join('doc', 'historic_bitstamp_data.txt')
      text = File.read(file)
      rows =    text.split("],")

      rows.each do |row|
        items = row.split(",")
        date_time = Time.at(items[0].gsub("[", "").to_i)
        open = items[1]
        high = items[2]
        low = items[3]
        close = items[4]
        volume_btc= items[5]
        volume_currency = items[6]
        avg_price = items[7]
        exchange = "bitstampUSD"
        
        bhp = BitcoinHistoricPrice.new(
          price_at: date_time, 
          open: open, 
          close: close, 
          high: high, 
          low: low, 
          volume_btc: volume_currency, 
          volume_currency: volume_currency,
          avg_price: avg_price, 
          exchange: exchange          
        ) 
        bhp.save
    end
    rescue Exception => e
      puts e.backtrace
    end
  end

end