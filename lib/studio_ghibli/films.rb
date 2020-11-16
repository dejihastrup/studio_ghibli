class StudioGhibli::Films

    attr_accessor :title, :description, :director, :producer, :release_date, :rt_score

    @@films = []

    def initialize(title, description, director, producer, release_date, rt_score)
        @title = title
        @description = description
        @director = director
        @producer = producer
        @release_date = release_date
        @rt_score = rt_score
        self.class.films << self
    end

    def self.films
        @@films
    end

end