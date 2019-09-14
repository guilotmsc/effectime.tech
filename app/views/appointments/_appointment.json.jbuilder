json.extract! appointment, :id, :employee_id, :contract_id, :project_id, :start, :end, :canceled, :description, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
