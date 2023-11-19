json.extract! user, :id, :password, :passport, :surname, :firstname, :middlename, :born_date, :address, :admin, :inspector, :created_at, :updated_at
json.url user_url(user, format: :json)
