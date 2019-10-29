class CorporationsController < ApplicationController
  before_action :set_corporation, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  skip_authorize_resource :only => [:get_users_by_corporation, :new]

  def get_users_by_corporation
    users = User.find_by_sql("select users.id, users.email, users.created_at, corporation_users.admin,
                              corporation_users.id as corporation_users_id from users 
                              inner join corporation_users on corporation_users.user_id = users.id
                              where corporation_users.corporation_id = #{params[:corporation_id]}
                              order by users.created_at asc")
    
    return render :json => users
  end

  # GET /corporations
  # GET /corporations.json
  def index
    @corporations = Corporation.all.joins(:corporation_users).where("corporation_users.user_id = #{User.current.id}")
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
    @user_corporations = CorporationUser.all.where(corporation_id: params[:id])
  end

  # POST /corporations
  # POST /corporations.json
  def create
    @corporation = Corporation.new(corporation_params)

    respond_to do |format|
      if @corporation.save
        CorporationUser.create(:user_id => User.current.id, :corporation_id => @corporation.id, :admin => true)

        if !params[:areas_array].blank?
          Area.where("id in (#{params[:areas_array]})").update(:corporation_id => @corporation.id)  
        end

        if params[:emails_array].present?
          emails = params[:emails_array].split(',')

          emails.each_with_index do |email, index|
            check_user = User.find_by_email(emails[index])

            if check_user.present?
              check_corporation_user = CorporationUser.find_by_sql("select * from corporation_users where corporation_id = #{@corporation.id} and user_id = #{check_user.id}")
              
              if !check_corporation_user.present?
                CorporationInviteMailer.with(corporation: @corporation, email: emails[index]).corporation_invite_email.deliver_now
                CorporationUser.create(:user_id => check_user.id, :corporation_id => @corporation.id, :admin => false)
              end
            else
              user = User.invite!(:email => emails[index])
              CorporationUser.create(:user_id => user.id, :corporation_id => @corporation.id, :admin => false)
            end
          end
        end
        
        format.html { redirect_to new_client_path }
        format.json { head :no_content }
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
          format.html { redirect_to corporations_path }
          format.json { head :no_content }  
        else
          format.html { redirect_to corporations_path }
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
        format.html { redirect_to corporations_path }
        format.json { head :no_content }  
      else
        format.html { redirect_to corporations_path }
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
                                          :phone, :city, :state, :contact, :role, :contact_phone, :email)
    end
end
