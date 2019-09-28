class CorporationsController < ApplicationController
  before_action :set_corporation, only: [:show, :edit, :update, :destroy]

  def index_clients
    @corporations = Corporation.all.joins("inner join workspace_users on workspace_users.workspace_id = corporations.workspace_id").where("workspace_users.user_id = #{User.current.id} and corporation_type_id = 1")
  end  

  def index_companies
    @corporations = Corporation.all.joins("inner join workspace_users on workspace_users.workspace_id = corporations.workspace_id").where("workspace_users.user_id = #{User.current.id} and corporation_type_id = 2")
  end  

  # GET /corporations
  # GET /corporations.json
  def index
    @corporations = Corporation.all
  end

  # GET /corporations/1
  # GET /corporations/1.json
  def show
  end

  # GET /corporations/new
  def new
    @corporation = Corporation.new
  end

  # GET /corporations/1/edit
  def edit
    @areas = Area.all.where(corporation_id: params[:id])
  end

  # POST /corporations
  # POST /corporations.json
  def create
    @corporation = Corporation.new(corporation_params)

    respond_to do |format|
      if @corporation.save
        if !params[:areas_array].blank?
          Area.where("id in (#{params[:areas_array]})").update(:corporation_id => @corporation.id)  
        end

        if params[:emails_array].present?
          emails = params[:emails_array].split(',')

          emails.each_with_index do |email, index|
            user = User.invite!(:email => emails[index])
            
            WorkspaceUser.create(:user_id => user.id, :workspace_id => params[:corporation][:workspace_id], :admin => false)
          end
        end
        
        if @corporation.corporation_type_id== 1
          format.html { redirect_to index_clients_corporations_path }
          format.json { head :no_content }  
        else
          # format.html { redirect_to index_companies_corporations_path, notice: 'Corporation was successfully destroyed.' }
          format.html { redirect_to new_client_path }
          format.json { head :no_content }
        end
      else
        format.html { render :new }
        format.json { render json: @corporation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /corporations/1
  # PATCH/PUT /corporations/1.json
  def update
    respond_to do |format|
      if @corporation.update(corporation_params)
        if @corporation.corporation_type_id == 1
          format.html { redirect_to index_clients_corporations_path }
          format.json { head :no_content }  
        else
          format.html { redirect_to index_companies_corporations_path }
          format.json { head :no_content }
        end
      else
        format.html { render :edit }
        format.json { render json: @corporation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corporations/1
  # DELETE /corporations/1.json
  def destroy
    @corporation.destroy
    respond_to do |format|
      if @corporation.corporation_type_id == 1
        format.html { redirect_to index_clients_corporations_path }
        format.json { head :no_content }  
      else
        format.html { redirect_to index_companies_corporations_path }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_corporation
      @corporation = Corporation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def corporation_params
      params.require(:corporation).permit(:name, :corporation_type_id, :trading_name, :document, :address,
                                          :phone, :city, :state, :contact, :role, :contact_phone, :email,
                                          :workspace_id)
    end
end
