json.array!(@orders) do |order|
  json.extract! order, :id, :vidrio, :carton, :lata, :plastico, :address, :description, :status, :assigned, :user_id, :facebook_id
  json.url order_url(order, format: :json)
end
