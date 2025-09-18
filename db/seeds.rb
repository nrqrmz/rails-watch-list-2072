require 'uri'
require 'net/http'
require 'json'

url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=3")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZDU5NmY1ZDIyOTg4MjU3OTIyNmMzYzAzZTNlMjZkNiIsIm5iZiI6MTc0ODEwMDQ3NS45NTM5OTk4LCJzdWIiOiI2ODMxZTU3YjZkNzA3OGM4NjE0MTM5N2UiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.iRuH55Wvv30SIoozib-XT2F43cWMXo5xD6LcelV02t8'

response = JSON.parse(http.request(request).read_body)
results = response['results']

results.each do |movie|
  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end
