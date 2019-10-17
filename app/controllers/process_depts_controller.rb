class ProcessDeptsController < ApplicationController
  before_action :set_process_dept, only: [:show, :edit, :update, :destroy]

  def create_process
    process = ProcessDept.create(:name => params[:name], :area_id => params[:area_id])

    return render :json => process
  end

  def edit_process
    process = ProcessDept.where(id: params[:process_id]).update(:name => params[:name])

    return render :json => process
  end

  def delete_process
    process = ProcessDept.find(params[:id])
    process.destroy

    return render json: {}, status: 200
  end

  def get_process_by_corporation
    process = ProcessDept.find_by_sql("select distinct process_depts.* 
                                      from process_depts 
                                      inner join areas on process_depts.area_id in 
                                      (select areas.id from areas where corporation_id = #{params[:id]})
                                      order by id asc")

    return render :json => process
  end

  # GET /process_depts
  # GET /process_depts.json
  def index
    @process_depts = ProcessDept.all
  end

  # GET /process_depts/1
  # GET /process_depts/1.json
  def show
  end

  # GET /process_depts/new
  def new
    @process_dept = ProcessDept.new
  end

  # GET /process_depts/1/edit
  def edit
  end

  # POST /process_depts
  # POST /process_depts.json
  def create
    @process_dept = ProcessDept.new(process_dept_params)

    respond_to do |format|
      if @process_dept.save
        format.html { redirect_to @process_dept, notice: 'Process dept was successfully created.' }
        format.json { render :show, status: :created, location: @process_dept }
      else
        format.html { render :new }
        format.json { render json: @process_dept.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /process_depts/1
  # PATCH/PUT /process_depts/1.json
  def update
    respond_to do |format|
      if @process_dept.update(process_dept_params)
        format.html { redirect_to @process_dept, notice: 'Process dept was successfully updated.' }
        format.json { render :show, status: :ok, location: @process_dept }
      else
        format.html { render :edit }
        format.json { render json: @process_dept.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /process_depts/1
  # DELETE /process_depts/1.json
  def destroy
    @process_dept.destroy
    respond_to do |format|
      format.html { redirect_to edit_area_path(@process_dept.area_id), notice: 'Process dept was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_process_dept
      @process_dept = ProcessDept.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def process_dept_params
      params.require(:process_dept).permit(:area_id, :name)
    end
end
