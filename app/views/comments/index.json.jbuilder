json.array!(@comments) do |comment|
  json.extract! comment, :email, :text
  json.url comment_url(comment, format: :json)
end
