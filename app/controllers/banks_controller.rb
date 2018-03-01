class BanksController < ApplicationController

  def index    
    banks = Bank.all
    render json: banks.as_json
  end

  def show
    bank = Bank.find_by(id: params[:id])
    render json: bank.as_json    
  end  

end
