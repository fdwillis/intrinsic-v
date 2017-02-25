class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  def index
    @stocks = Stock.all.map(&:symbol)
  end

  # GET /admin_actions/1
  # GET /admin_actions/1.json
  def show
  end

  # GET /admin_actions/new
  def new
    @admin_action = Stock.new
  end

  # GET /admin_actions/1/edit
  def edit
  end

  # POST /admin_actions
  # POST /admin_actions.json
  def create
    @admin_action = Stock.new(stock_params)
    
    
    respond_to do |format|
      if @admin_action.save
        
        format.html { redirect_to root_path, notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: @admin_action }
      else
        format.html { redirect_to new_stock_path }
        format.json { render json: @admin_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_actions/1
  # PATCH/PUT /admin_actions/1.json
  def update
    
    respond_to do |format|
      if @admin_action.update(stock_params)
        format.html { redirect_to root_path, notice: 'Admin action was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_action }
      else
        format.html { render :edit }
        format.json { render json: @admin_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_actions/1
  # DELETE /admin_actions/1.json
  def destroy
    @admin_action.destroy
    respond_to do |format|
      format.html { redirect_to admin_actions_url, notice: 'Admin action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
    
      @admin_action = Stock.find_by(symbol: params[:id])

      if !@admin_action.present?
        redirect_to root_path
        flash[:error] = "That's not in the system"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:symbol, :old_bv, :bv_years, :admin_only, :admin_fav, logs_attributes: [:id, :price, :equity, :shares,:net_income, :bv, :year, :quarter, :coupon, :_destroy])
    end
end
