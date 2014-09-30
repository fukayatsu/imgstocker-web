json.icons do
  json.array!(@icons, :id, :user_id, :name, :original_filename, :created_at, :updated_at)
end
json.user do
  json.(@user, :id, :provider, :uid)
end
