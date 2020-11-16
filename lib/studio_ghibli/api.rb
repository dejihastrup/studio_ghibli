class StudioGhibli::API

    attr_accessor :query

    def initialize(query)
        @query = query
    end

    def self.fetch_films
        url = "https://ghibliapi.herokuapp.com/films"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        films = JSON.parse(response) 
    end

    def create_film
        film = self.class.fetch_films[@query.to_i - 1]
        StudioGhibli::Films.new(film["title"], film["description"], film["director"], film["producer"],
        film["release_date"], film["rt_score"])
    end

end

# api = StudioGhibli::Api.new
# # binding.pry 
# "please god"