class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.joins("inner join corporations on contracts.corporation_id = corporations.id").where("corporations.workspace_id in (select workspace_id from workspace_users where user_id = #{User.current.id})")
    @clients = Corporation.where("corporation_type_id = 1 and workspace_id in (select workspace_id from workspace_users where user_id = #{User.current.id})").count(:id)
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)

    respond_to do |format|
      if @contract.save
        format.html { redirect_to contracts_path, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to contracts_path, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_path, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.require(:contract).permit(:corporation_id, :name, :scope, :contract_type, :signature_date, :attribuition_model, 
                                        :attribuition_model_day, :attribuition_model_week_day, :attribuition_model_invalid_day, 
                                        :attribuition_model_validate_day, :recurrent_tickets, :hours_volume, :amount_ticket, :tolerance,
                                        :maturity_day, :input_value, :billing_date, :quotas, :quota_amount, :recurrent_amount, 
                                        :scope_ticket_amount, :billing_day, :recurring_amount_ticket, :overplus_ticket_amout,
                                        :extra_hour_amount)
    end
end
