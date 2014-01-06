json.array!(@bitcoin_prices) do |bitcoin_price|
  json.extract! bitcoin_price, :id
  json.url bitcoin_price_url(bitcoin_price, format: :json)
end
