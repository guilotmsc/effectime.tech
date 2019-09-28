class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def get_clients
    @result = Corporation.joins(:corporation_users).where("corporation_users.user_id = #{User.current.id} and corporation_type_id = 1")
    respond_to do |format|
      format.json { render :json => @result }
    end
  end 

  def get_corporations
    @result = Corporation.joins(:corporation_users).where("corporation_users.user_id = #{User.current.id} and corporation_type_id = 2")

    respond_to do |format|
      format.json { render :json => @result }
    end
  end

  def get_contracts_by_client
    @result = Contract.where(client_id: params[:client])
    respond_to do |format|
      format.json { render :json => @result }
    end
  end

  def get_areas_by_corporation
    @result = Area.where(corporation_id: params[:client])
    respond_to do |format|
      format.json { render :json => @result }
    end
  end

  def get_areas_by_client
    @result = Area.where(client_id: params[:client])
    respond_to do |format|
      format.json { render :json => @result }
    end
  end

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.joins("left outer join clients on clients.id = projects.client_id")
                       .where("(projects.corporation_id in (
                              select corporation_id from corporation_users where user_id = #{User.current.id})
                              or
                              clients.corporation_id in (
                              select corporation_id from corporation_users where user_id = #{User.current.id}))")
    @corporations = Corporation.where("corporation_type_id = 2 and id in (select corporation_id from corporation_users where user_id = #{User.current.id})").count(:id)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_path, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :contract_id, :corporation_id, :type_project, :area_id, :sponsor, :manager, :objective, 
                                      :client_id, :start_date, :end_date, :estimate, :obs, :associate, :code, user_ids:[])
    end
end