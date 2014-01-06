class CreateBitcoinPrices < ActiveRecord::Migration
  def change
    create_table :bitcoin_prices do |t|

      t.timestamps
    end
  end
end
