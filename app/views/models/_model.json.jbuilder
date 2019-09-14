json.extract! model, :id, :name, :status, :created_at, :updated_at
json.url model_url(model, format: :json)
