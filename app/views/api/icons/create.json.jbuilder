json.icon do
  json.(@icon, :id, :user_id, :name, :original_filename, :created_at, :updated_at)
end
json.user do
  json.(@icon.user, :id, :provider, :uid)
end
