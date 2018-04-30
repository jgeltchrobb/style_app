json.extract! post, :id, :content, :image, :owner_role, :created_at, :updated_at
json.url post_url(post, format: :json)
