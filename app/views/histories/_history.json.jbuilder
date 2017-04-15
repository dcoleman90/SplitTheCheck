json.extract! history, :id, :restaurant_id, :user_id, :up_votes_added, :down_votes_added, :up_votes_total, :down_votes_total, :created_at, :updated_at
json.url history_url(history, format: :json)
