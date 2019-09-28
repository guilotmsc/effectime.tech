class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  def create_area
    area = Area.create(:name => params[:name])

    return render :json => area
  end

  def edit_area
    area = Area.where(id: params[:area_id]).update(:name => params[:name])

    return render :json => area
  end

  def delete_area
    area = Area.find(params[:id])
    area.destroy

    return render json: {}, status: 200
  end 

  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
    @area_depts = ProcessDept.where(area_id: params[:id]).all
    @area = Area.find_by_id(params[:id])
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        Area.create_process(params[:process], @area.id)
        format.html { redirect_to areas_path, notice: 'Area was successfully created.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to "/corporations/#{@area.corporation_id}/edit", notice: 'Area was successfully updated.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to areas_path, notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name, :corporation_id, :client_id)
    end
end
