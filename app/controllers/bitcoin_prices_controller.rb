class BitcoinPricesController < ApplicationController
  before_action :set_bitcoin_price, only: [:show, :edit, :update, :destroy]

  # GET /bitcoin_prices
  # GET /bitcoin_prices.json
  def index
    # @bitcoin_prices = BitcoinPrice.all

    @mtgox = MtGox.ticker

    @bitstamp = Bitstamp.ticker

    @btce = Btce::Ticker.new "btc_usd"

    coinbase = Coinbase::Client.new("5d6e5a7891b129eea78841b5995be2c762883b14709b2cc2575f79f767e8ce24")

    @coinbase_buy = coinbase.buy_price(1).format
    @coinbase_sell = coinbase.sell_price(1).format

  end

  # GET /bitcoin_prices/1
  # GET /bitcoin_prices/1.json
  def show
  end

  # GET /bitcoin_prices/new
  def new
    @bitcoin_price = BitcoinPrice.new
  end

  # GET /bitcoin_prices/1/edit
  def edit
  end

  # POST /bitcoin_prices
  # POST /bitcoin_prices.json
  def create
    @bitcoin_price = BitcoinPrice.new(bitcoin_price_params)

    respond_to do |format|
      if @bitcoin_price.save
        format.html { redirect_to @bitcoin_price, notice: 'Bitcoin price was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bitcoin_price }
      else
        format.html { render action: 'new' }
        format.json { render json: @bitcoin_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bitcoin_prices/1
  # PATCH/PUT /bitcoin_prices/1.json
  def update
    respond_to do |format|
      if @bitcoin_price.update(bitcoin_price_params)
        format.html { redirect_to @bitcoin_price, notice: 'Bitcoin price was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bitcoin_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bitcoin_prices/1
  # DELETE /bitcoin_prices/1.json
  def destroy
    @bitcoin_price.destroy
    respond_to do |format|
      format.html { redirect_to bitcoin_prices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bitcoin_price
      @bitcoin_price = BitcoinPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bitcoin_price_params
      params[:bitcoin_price]
    end
end
