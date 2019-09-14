class CorporationTypesController < ApplicationController
  before_action :set_corporation_type, only: [:show, :edit, :update, :destroy]

  # GET /corporation_types
  # GET /corporation_types.json
  def index
    @corporation_types = CorporationType.all
  end

  # GET /corporation_types/1
  # GET /corporation_types/1.json
  def show
  end

  # GET /corporation_types/new
  def new
    @corporation_type = CorporationType.new
  end

  # GET /corporation_types/1/edit
  def edit
  end

  # POST /corporation_types
  # POST /corporation_types.json
  def create
    @corporation_type = CorporationType.new(corporation_type_params)

    respond_to do |format|
      if @corporation_type.save
        format.html { redirect_to @corporation_type, notice: 'Corporation type was successfully created.' }
        format.json { render :show, status: :created, location: @corporation_type }
      else
        format.html { render :new }
        format.json { render json: @corporation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /corporation_types/1
  # PATCH/PUT /corporation_types/1.json
  def update
    respond_to do |format|
      if @corporation_type.update(corporation_type_params)
        format.html { redirect_to @corporation_type, notice: 'Corporation type was successfully updated.' }
        format.json { render :show, status: :ok, location: @corporation_type }
      else
        format.html { render :edit }
        format.json { render json: @corporation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corporation_types/1
  # DELETE /corporation_types/1.json
  def destroy
    @corporation_type.destroy
    respond_to do |format|
      format.html { redirect_to corporation_types_url, notice: 'Corporation type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_corporation_type
      @corporation_type = CorporationType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def corporation_type_params
      params.require(:corporation_type).permit(:name)
    end
end
