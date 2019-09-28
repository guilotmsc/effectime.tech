class WorkspaceUsersController < ApplicationController
  before_action :set_workspace_user, only: [:show, :edit, :update, :destroy]

  # GET /workspace_users
  # GET /workspace_users.json
  def index
    @workspace_users = WorkspaceUser.all
  end

  # GET /workspace_users/1
  # GET /workspace_users/1.json
  def show
  end

  # GET /workspace_users/new
  def new
    @workspace_user = WorkspaceUser.new
  end

  # GET /workspace_users/1/edit
  def edit
  end

  # POST /workspace_users
  # POST /workspace_users.json
  def create
    @workspace_user = WorkspaceUser.new(workspace_user_params)

    respond_to do |format|
      if @workspace_user.save
        format.html { redirect_to @workspace_user, notice: 'Workspace user was successfully created.' }
        format.json { render :show, status: :created, location: @workspace_user }
      else
        format.html { render :new }
        format.json { render json: @workspace_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workspace_users/1
  # PATCH/PUT /workspace_users/1.json
  def update
    respond_to do |format|
      if @workspace_user.update(workspace_user_params)
        format.html { redirect_to @workspace_user, notice: 'Workspace user was successfully updated.' }
        format.json { render :show, status: :ok, location: @workspace_user }
      else
        format.html { render :edit }
        format.json { render json: @workspace_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workspace_users/1
  # DELETE /workspace_users/1.json
  def destroy
    @workspace_user.destroy
    respond_to do |format|
      format.html { redirect_to workspace_users_url, notice: 'Workspace user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace_user
      @workspace_user = WorkspaceUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workspace_user_params
      params.require(:workspace_user).permit(:workspace_id, :user_id)
    end
end
