class CreateBitcoinHistoricPrice < ActiveRecord::Migration
  def change
    create_table :bitcoin_historic_prices do |t|
      t.column :price_at, :datetime
      t.string :open
      t.string :close
      t.string :high
      t.string :low
      t.string :volume_btc
      t.string :volume_currency
      t.string :avg_price
      t.string :exchange
      t.timestamps
    end
  end
end
