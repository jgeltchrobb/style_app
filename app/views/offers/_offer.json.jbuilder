json.extract! offer, :id, :price, :time, :in_person?, :user_id, :created_at, :updated_at
json.url offer_url(offer, format: :json)
