json.extract! model, :id, :login, :password, :passport, :surname, :firstname, :middlename, :born_date, :address, :admin, :inspector, :created_at, :updated_at
json.url model_url(model, format: :json)
