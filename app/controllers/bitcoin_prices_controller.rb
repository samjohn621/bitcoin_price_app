require 'actionpack/action_caching'
class BitcoinPricesController < ApplicationController

  # caches_action :index, :expires_in => 20.second
  def index
    respond_to do |format|
      # format.html  { render :index  }
      format.json  { render_for_api :price, :json =>  BitcoinPrice.new , :root => :price }
    end
  end
end
