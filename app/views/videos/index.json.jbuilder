json.array!(@videos) do |video|
  json.extract! video, :video
  json.url video_url(video, format: :json)
end
