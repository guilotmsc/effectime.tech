class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def export
    # require 'csv'

    @appointments = Appointment.find_by_sql("select 
            pj.corporation_id as pc_id,
            c.corporation_id as c_id,
            co.id as co_id,
            corp_process.name as empresa,
            c.name as corporacao,
            co.name as contrato,
            pj.name as projeto,
            a.name as area,
            pd.name as processo,
            u.username as usuario,
            TO_CHAR(start_moment, 'dd/mm/yyyy') as date,
            TO_CHAR(start_moment, 'HH:mi') as inicio,
            TO_CHAR(end_moment, 'HH:mi') as termino  
          from appointments p 
          inner join users u on u.id = #{User.current.id}
          left outer join process_depts pd on pd.id = p.process_dept_id
          left outer join projects pj on pj.id = p.project_id
          left outer join areas a on a.id = pd.area_id
          left outer join corporations corp_process on corp_process.id = a.corporation_id
          left outer join contracts c on c.id = p.contract_id
          left outer join corporations co on co.id = c.corporation_id")
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @appointments.to_csv }
    #   format.xls 
    # end
    respond_to do |format|
        format.xlsx {
          response.headers[
            'Content-Disposition'
          ] = "attachment; filename=registro-de-horas.xlsx"
        }
        format.html { render :index }
    end
  end

  # POST /appointments/create_appointment
  def create_appointment
    appointment = Appointment.create(:user_id => User.current.id,
                              :start => params[:start],
                              :end => params[:end],
                              :description => params[:description])

    return render :json => 'Appointment was successfully created'
  end

  def delete_appointment
    Appointment.find(params[:id]).destroy

    render json: {}, status: 200
  end

  def get_appointment
    appointment = Appointment.find(params[:id])

    if appointment.contract_id?
      info = Contract.joins("inner join corporations on contracts.corporation_id = corporations.id")
                      .select("contracts.*, corporations.name as client_name")
                      .where(id: appointment[:contract_id]).first
    elsif appointment.project_id?
      info = Project.joins("left outer join contracts on projects.contract_id = contracts.id
                            inner join areas on projects.area_id = areas.id")
                    .select("projects.*, coalesce(contracts.name, 'Nenhum contrato') as contract_name, areas.name as area_name")
                    .where(id: appointment[:project_id]).first
    elsif appointment.process_dept_id?
      info = ProcessDept.joins("inner join areas on process_depts.area_id = areas.id")
                        .select("process_depts.*, areas.name as area_name")
                        .where(id: appointment[:process_dept_id]).first
    
    end

    render :json => info
  end

  def list_appointment
    # appointments = Appointment.all.where(["appointments.employee_id = :employee_id and canceled = :canceled", { employee_id: User.current.id, canceled: false }])
    appointments = Appointment.joins("left outer join projects on appointments.project_id = projects.id
                                      left outer join process_depts on appointments.process_dept_id = process_depts.id")
                  .select("appointments.*, 
                          case when appointments.project_id is null then 
                                process_depts.name
                               when appointments.process_dept_id is null then 
                                projects.name
                          end as name").
                  where(["appointments.user_id = :user_id", { user_id: User.current.id }])

                  #where(["appointments.user_id = :user_id and canceled = :canceled", { user_id: User.current.id, canceled: false }])

    # appointments = Appointment.joins("left outer join contracts on appointments.contract_id = contracts.id
    #                                left outer join projects on appointments.project_id = projects.id")
    #               .select("appointments.*, 
    #                       case when contracts.client is null then projects.name else contracts.client end as name,
    #                       case when contracts.client is null 
    #                         then 
    #                           'Área de atuação:<b> ' || '' ||  
    #                           coalesce(area, '') || '</br></b> Patrocinador:<b> ' ||  
    #                           sponsor || '<br> </b>Gerente de projetos: <b>' || 
    #                           manager || '<br> </b>Início: <b>' || 
    #                           start_date || '<br> </b>Término: <b>' || 
    #                           end_date || '<br> </b>Objetivo: <b>' || 
    #                           objective || '<br> </b>Orçamento: <b>' ||
    #                           projects.estimate || '<br>'
    #                         else 
    #                           'Nome fantasia:<b> ' || '' ||  
    #                           coalesce(trading_name, '') || '</br> </b>Data da assinatura: <b>' ||
    #                                signature_date || '<br> </b>Data de fechamento de controle de horas: <b>' || 
    #                                date_closing_hours || '<br> </b>Total: <b>' || 
    #                                amount || '<br> </b>Valor do ticket: <b>' || 
    #                                amount_ticket || '<br> </b>Dia do pagamento: <b>' ||
    #                                hours_volume || '</b>'
    #                       end as info")
    #               .where(["appointments.employee_id = :employee_id and canceled = :canceled", { employee_id: User.current.id, canceled: false }])

#     appointments = Appointment.find_by_sql("SELECT appointments.*, 
#   contracts.client as name,
#   'Nome fantasia: ' || '' || coalesce(trading_name, '') as info1,
#   'Data da assinatura: ' || signature_date as info2,
#   'Data de fechamento de controle de horas: ' || date_closing_hours as info3,
#   'Total: ' || amount as info4,
#   'Valor do ticket: ' || amount_ticket as info5,
#         'Dia do pagamento: ' || payday as info6,
#   'Horas contratadas: ' || hours_volume as info7
# FROM appointments
# left outer join contracts on appointments.contract_id = contracts.id
# WHERE (appointments.employee_id = #{User.current.id} and canceled = 'f') and contract_id is not null

# union all

# SELECT appointments.*, 
#   projects.name as name,
#   'Área de atuação: ' || '' || coalesce(area, '') as info1,
#   'Patrocinador: ' || sponsor as info2,
#   'Gerente de projetos: ' || manager as info3,
#   'Objetivo: ' || objective as info4,
#   'Orçamento: ' || estimate as info5,
#         'Início: ' || estimate as info6,
#   'Término: ' || estimate as info7
# FROM appointments
# left outer join projects on appointments.project_id = projects.id 
# WHERE (appointments.employee_id = #{User.current.id} and canceled = 'f') and project_id is not null")

    return render :json => appointments
  end

  def register_appointment
    if params[:type] == 'project'
      appointment = Appointment.create(:user_id => User.current.id, :project_id => params[:id], :appointment_type => 'project', :start_moment => params[:start], :end_moment => params[:end], :description => 'teste')  
    elsif params[:type] == 'contract'
      appointment = Appointment.create(:user_id => User.current.id, :contract_id => params[:id], :appointment_type => 'contract', :start_moment => params[:start], :end_moment => params[:end], :description => 'teste')
    else
      appointment = Appointment.create(:user_id => User.current.id, :process_dept_id => params[:id], :appointment_type => 'process', :start_moment => params[:start], :end_moment => params[:end], :description => 'teste')
    end
    
    return render :json => appointment
  end

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
    @appExport = Appointment.find_by_sql("
                    select 
                      pj_corp.name as pc_id,
                      pd_corp.name as pd_id,
                      pj.name as projeto,
                      pj_area.name as area,
                      pd.name as processo,
                      u.username as usuario,
                      TO_CHAR(start_moment, 'dd/mm/yyyy') as date,
                      TO_CHAR(start_moment, 'HH24:mi') as inicio,
                      TO_CHAR(end_moment, 'HH24:mi') as termino  
                    from appointments p 
                    inner join users u on u.id = p.user_id
                    left outer join process_depts pd on pd.id = p.process_dept_id
                    left outer join projects pj on pj.id = p.project_id
                    left outer join areas pj_area on pj_area.id = pj.area_id
                    left outer join corporations pj_corp on pj.corporation_id = pj_corp.id
                    left outer join areas area_pd on area_pd.id = pd.area_id
                    left outer join corporations pd_corp on area_pd.corporation_id = pd_corp.id")
    @contracts = Contract.where("corporation_id in (select corporation_id from corporation_users where user_id = #{User.current.id})")
    @projects = Project.where("corporation_id in (select corporation_id from corporation_users where user_id = #{User.current.id})")
    @process = ProcessDept.find_by_sql("select process_depts.* from process_depts
                    inner join areas on process_depts.area_id = areas.id
                    where areas.corporation_id in (select corporation_id from corporation_users where user_id = #{User.current.id})")
    
    respond_to do |format|
      format.xlsx {
          response.headers[
            'Content-Disposition'
          ] = "attachment; filename=registro-de-horas.xlsx"
        }
        format.html { render :index }
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:employee_id, :contract_id, :project_id, :appointment_type, :start_moment, :end_moment, :canceled, :description)
    end
end
