class CorporationUsersController < ApplicationController
  before_action :set_corporation_user, only: [:show, :edit, :update, :destroy]

  # GET /corporation_users
  # GET /corporation_users.json
  def index
    @corporation_users = CorporationUser.all
  end

  # GET /corporation_users/1
  # GET /corporation_users/1.json
  def show
  end

  # GET /corporation_users/new
  def new
    @corporation_user = CorporationUser.new
  end

  # GET /corporation_users/1/edit
  def edit
  end

  # POST /corporation_users
  # POST /corporation_users.json
  def create
    @corporation_user = CorporationUser.new(corporation_user_params)

    respond_to do |format|
      if @corporation_user.save
        format.html { redirect_to @corporation_user, notice: 'Corporation user was successfully created.' }
        format.json { render :show, status: :created, location: @corporation_user }
      else
        format.html { render :new }
        format.json { render json: @corporation_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /corporation_users/1
  # PATCH/PUT /corporation_users/1.json
  def update
    respond_to do |format|
      if @corporation_user.update(corporation_user_params)
        format.html { redirect_to @corporation_user, notice: 'Corporation user was successfully updated.' }
        format.json { render :show, status: :ok, location: @corporation_user }
      else
        format.html { render :edit }
        format.json { render json: @corporation_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corporation_users/1
  # DELETE /corporation_users/1.json
  def destroy
    @corporation_user.destroy
    respond_to do |format|
      format.html { redirect_to edit_corporation_path(@corporation_user.corporation_id), notice: 'Corporation user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_corporation_user
      @corporation_user = CorporationUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def corporation_user_params
      params.require(:corporation_user).permit(:corporation_id, :user_id, :admin)
    end
end
