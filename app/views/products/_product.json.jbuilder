json.extract! product, :id, :name, :description, :price, :stock_quantity, :image_url, :created_at, :updated_at
json.url product_url(product, format: :json)
