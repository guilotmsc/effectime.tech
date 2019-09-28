json.extract! client, :id, :name, :address, :city, :state, :trading_name, :document, :phone, :contact, :role, :contact_phone, :email, :created_at, :updated_at
json.url client_url(client, format: :json)
