class StudioGhibli::CLI

    attr_accessor :film_count, :film 
    YEAR = 2020

    def initialize
        self.film_count = 0
        self.film = ''
    end

    def call 
        puts ""
        puts "Welcome to the world of Studio Ghibli!"
        puts ""
        totoro_art
        puts ""
        puts "To learn about your favourite Studio Ghibli films, enter 'films'." 
        puts "To exit the Studio Ghibli World, enter 'exit.'"
        puts ""

        input = gets.strip.downcase 
        intro(input)
    end

    def list_films
        puts ""
        puts "Here are all the Studio Ghibli films to date:"
        puts ""
        StudioGhibli::API.fetch_films.each.with_index(1) do |film, index|
            puts "#{index}.   #{film["title"]}" 
        end 
        
        puts ""
        puts "Which film would you like to learn about?" 
        puts "Please enter (1-20) or 'exit' to leave the Studio Ghibli World."
        puts ""
        input = gets.strip.downcase
        film_choice(input)
    end

    def film_info(input)
        query = StudioGhibli::API.new(input)
        query.create_film
        self.film = StudioGhibli::Films.films[self.film_count]
        choose_info
    end

    def choose_info
        puts ""
        puts "What would you like to know about #{self.film.title}?" 
        puts "Please enter (1-5) or 'exit' to leave the Studio Ghibli World."
        puts "" 
        self.film.instance_variables.drop(1).each.with_index(1) do |variable, index|
            if index != (self.film.instance_variables.size - 1)
            puts "#{index}.   #{variable.to_s.delete("@").gsub(/_/, ' ').capitalize}" #metaprogramming but I want to customize attribute names.
            else
            puts "#{index}.   Rotten Tomato Score"
            end
        end
        puts ""

        input = gets.strip
        info(input)
    end     

    def more_info
        puts ""
        puts "Please enter (1-2) 'exit' to leave the Studio Ghibli World."
        puts "1.    I want to know more about this film!"
        puts "2.    I want to learn about a different film."
        puts ""

        input = gets.strip.downcase
        more_info_check(input)
    end

    def exit_world
        puts ""
        puts "Looks you've been spitited away!"
        puts ""
        spirited_away_art
        puts ""
        puts "Have a great day :)"
        puts ""
        exit
    end

    #input check

    def intro(answer)
        
        if answer == 'films'
            list_films
        elsif answer == 'exit'
            exit_world
        else 
            error = 1
            error_message(error)
        end
    end

    def film_choice(answer)
        if answer.to_i.between?(1, 20)
            film_info(answer)
        elsif answer == 'exit'
            exit_world
        else 
            error = 2
            error_message(error)
        end
    end 


    def info(input)
        case input
        when "1"
            puts "Here's a summary of what #{self.film.title} is about:"
            puts ""
            puts "#{self.film.description}"
            puts ""
            more_info
        when "2"
            puts ""
            puts "#{self.film.title} was directed by the great #{self.film.director}."
            puts ""
            more_info
        when "3"
            puts ""
            puts "#{self.film.title} was produced by the great #{self.film.producer}."
            puts ""
            more_info
        when "4"
            puts ""
            puts "#{self.film.title} came out in #{self.film.release_date}, which is #{years_ago(self.film.release_date)}"
            puts ""
            more_info
        when "5"
            puts ""
            puts "#{self.film.title} has a Rotten Tomato Score of #{self.film.rt_score}#{rt_score(self.film.rt_score)}"
            puts ""
            more_info
        when "exit"
            exit_world
        else
            error = 3 
            error_message(error)
        end
    end

    def more_info_check(input)
        case input
        when '1'
            choose_info
        when '2'
            self.film_count += 1
            list_films
        when 'exit'
            exit_world
        else
            error = 4
            error_message(error)
        end 
    end
             

    #calculations

    def years_ago(release_date)
        years = YEAR - release_date.to_i
        if years >= 10
            "#{years} years ago! Old but gold."
        else
            "#{years} years ago, a modern masterpiece!"
        end
    end

    def rt_score(score)
        if score.to_i >= 80
            ", obviously rated by the best film critics in the world!"
        else
            "... pshh, what do they know!"
        end
    end

    #error_message

    def message(stage)
        puts ""
        puts "It looks like you've entered an incorrect option. Please Enter '#{stage}' or 'exit'."
    end

    def error_message(version)
        case version
        when 1
            message("films")
            input = gets.strip.downcase 
            intro(input)
        when 2
            message("(1-20)")
            input = gets.strip.downcase 
            film_choice(input)
        when 3
            message("(1-5)")
            input = gets.strip.downcase 
            info(input)
        when 4
            message("(1-2)")
            input = gets.strip.downcase 
            more_info_check(input)
        end
    end


    

    #art

    def totoro_art     
        puts "                         ! !       ! !                    "
        puts "                        ! . !     ! . !                   "
        puts "                           ^^^^^^^^^ ^                    "
        puts "                         ^             ^                  "
        puts "                       ^  (0)       (0)  ^                " 
        puts "                      ^        \"\"         ^               "
        puts "                     ^   ***************    ^             "
        puts "                   ^   *                 *   ^            "
        puts "                  ^   *   /\\   /\\   /\\    *    ^          "
        puts "                 ^   *                     *    ^         "
        puts "                ^   *   /\\   /\\   /\\   /\\   *    ^        "
        puts "               ^   *                         *    ^       "
        puts "               ^  *                           *   ^       "  
        puts "               ^  *                           *   ^       "
        puts "                ^ *                           *  ^        "
        puts "                 ^*                           * ^         "
        puts "                 ^ *                         * ^           "
        puts "                  ^  *                      *  ^          "
        puts "                    ^  *       ) (         * ^            "
        puts "                        ^^^^^^^^ ^^^^^^^^^                "
    end

    def spirited_away_art
    puts "     　　　　　   ＿＿＿＿＿                                   "
    puts "　　　　　　　　　,,,-;:;:;:;:;:;:;:;:;:;:;:;:;ヽ              "
    puts "　　　　　　　 ／;:;:;:;:;:;:;:／￣￣￣￣￣￣￣￣ヽ               "  
    puts "　　　　　　　/;:;:;:;:;:;:;:;/　.:::　　　::::.　|             "
    puts "　　　　　　/;:;:;:;:;:;:;:;:/　 .::::　　　::::　 |            "
    puts "　　　　　/;:;:;:;:;:;:;:;:;:|　(llll)　　 (llll)  |           "
    puts "　　　　 /;:;:;:;:;:;:;:;:;:;|　 ﾟー　　 　  ﾟー　 !            "
    puts "　　　　/;:;:;:;:;:;:;:;::;;:;|　::::　　　::::  ,'            "
    puts "　　　 /;:;:;:;:;:;:;:;:;:;:;:|　::::　　　::::  /            "
    puts "　　  /:;:;:;:;:;:;:;:;:;:;:;:ヽ　　　 ⊂⊃　     /             "
    puts "　　 /;:;:;:;:;:;:;:;:;:;:;:;:;:｀‐-､._ ー ,.‐'              "
    puts "　　/;:;:;:;:;:;:;:;:;:;:;;:;:;:;:;:;:;:;:;:/               "
    end

end