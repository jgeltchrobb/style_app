json.extract! profile, :id, :username, :bio, :profile_pic, :rating, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
