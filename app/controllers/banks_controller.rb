class BanksController < ApplicationController

  def index    
    banks = Bank.all
    render json: banks.as_json

    search_str = params[:search]
      if search_str
        banks = banks.where("name LIKE ?", "%#{search_str}")
    end

  end

  def show
    
    bank = Bank.find_by(id: params[:id])
    render json: bank.as_json    
  end  

end
