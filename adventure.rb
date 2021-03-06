require_relative './config/environment.rb'
ActiveRecord::Base.logger = nil



class AdventureGame

    prompt = TTY::Prompt.new
    
    def initialize
        a = Artii::Base.new :font => 'slant'
        puts a.asciify('Choose your own Adventure').cyan 
        self.start_game()
        self.onwards()
    end

 
    def start_game

        puts "Welcome brave adventurer, or bored person just trying to play a game for a few minutes.".cyan
        puts "Please enter your Username:".green
    
        @username = gets.chomp

        @existing_user = User.find_by(name: @username)

        if @existing_user != nil
        @player_1 = @existing_user

        puts "Continue game?".cyan
        puts "Y/N?".cyan

        cont = gets.chomp.upcase

            if cont == "N"
                @existing_user.destroy
                start_game()    
            elsif cont == "Y"
                puts "Cool bro, have fun with that.".cyan
                onwards()
            else
                puts "Sorry, that is not a valid response.".cyan
                start_game()
            end
            
        else
        @player_1 = User.create({name: @username})

        puts "Please choose your Class.".green
        puts ""
        puts "Enter 1 for Wizard".magenta
        puts ""
        puts "Enter 2 for Warrior".yellow

        user_input = gets.chomp

            if user_input.to_i == 1
                @player_1 = User.find_by(name: @username)
                @player_1.update(role_id: 1, story_id: 1)
            elsif
                user_input.to_i == 2
                @player_1 = User.find_by(name: @username)
                @player_1.update(role_id: 2, story_id: 2)
            else
                puts "Sorry, that is not a valid role.".cyan
            end
        end    

    end

    def onwards
        
        def wrap(s, width=130)
            s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
        end

        def chill
            yield.each_char { |c| putc c; $stdout.flush; sleep 0.02 }
        end
            while true 
            
            puts ""
            chill do wrap("#{@player_1.story.text}".cyan) 
            end
            puts ""
            puts ""
            puts "Enter 1 for: #{@player_1.story.option_1}.".green
            puts ""
            puts "Enter 2 for: #{@player_1.story.option_2}.".green
            puts ""
            puts "Enter 3 to quit this dumb game. Seriously, why did you start it in the first place? You might come back and play later. Probably not though.".red
            puts ""
            user_choice = gets.chomp
        
            case user_choice.to_i
            
            when 1
                @player_1 = User.find_by(name: @username)
                pick = @player_1.story.option_1_link_id
                Tracker.create(story_id: @player_1.story.id, user_id: @player_1.id)
                @player_1.update(story_id: pick)
                case pick
                when 31
                    rng = [1,2,3,4,5,6,7,8,9,10]
                    if rng.sample <= 7
                        @player_1.update(story_id: 31)
                    else
                        @player_1.update(story_id: 50)
                    end
                when 33
                    rng = [1,2,3,4,5,6,7,8,9,10]
                    if rng.sample <= 5
                        @player_1.update(story_id: 33)
                    else
                        @player_1.update(story_id: 51)
                    end

                when 19
                    rng = [1,2,3,4,5,6,7,8,9,10]
                    if rng.sample <= 7 
                        @player_1.update(story_id: 19)
                    else
                        @player_1.update(story_id: 59)
                    end
                when 20
                    rng = [1,2,3,4,5,6,7,8,9,10]
                    if rng.sample <= 7
                        @player_1.update(story_id: 20)
                    else
                        @player_1.update(story_id: 58)
                    end
                when 45
                    @player_1.destroy
                    start_game()
                when 46
                    @player_1.destroy
                    return false
                when 47
                    score = Tracker.where(user_id: @player_1.id)
                    score = score.count

                    puts ""
                    puts "You finished in #{score} steps. Please enter your name.".light_blue
                    player_name = gets.chomp
                    Highscore.create(name: player_name, points: score)
                    awesomest = Highscore.order('points asc').first.points
                    best = Highscore.order('points asc').first.name
                    puts""
                    puts "Highscore Table"
                    puts ""
                    tp Highscore.limit(5).order('points asc'), :name, "points"
                    puts ""
                    puts "The record holder is #{best} completing in #{awesomest} steps."
                    @player_1.destroy
                    puts ""
                    puts "Go play a fun game now, like Smash Bros. or CoD".magenta
                    return false
                end
            when 2
                @player_1 = User.find_by(name: @username)
                pick = @player_1.story.option_2_link_id
                Tracker.create(story_id: @player_1.story.id, user_id: @player_1.id)
                @player_1.update(story_id: pick)
                    case pick
                    when 31
                        rng = [1,2,3,4,5,6,7,8,9,10]
                        if rng.sample <= 7
                            @player_1.update(story_id: 31)
                        else
                            @player_1.update(story_id: 50)
                        end
                    when 33
                        rng = [1,2,3,4,5,6,7,8,9,10]
                        if rng.sample <= 5
                            @player_1.update(story_id: 33)
                        else
                            @player_1.update(story_id: 51)
                        end
                    when 19
                        rng = [1,2,3,4,5,6,7,8,9,10]
                        if rng.sample <=7
                            @player_1.update(story_id: 19)
                        else
                            @player_1.update(story_id: 59)
                        end
                    when 20
                        rng = [1,2,3,4,5,6,7,8,9,10]
                        if rng.sample <= 7
                            @player_1.update(story_id: 20)
                        else
                            @player_1.update(story_id: 58)
                        end
                    when 45
                        @player_1.destroy
                        start_game()
                    when 46
                        @player_1.destroy
                        return false
                    when 47
                        score = Tracker.where(user_id: @player_1.id)
                        score = score.count
                        
                        puts ""
                        puts "You finished in #{score} steps. Please enter your name.".light_magenta
                        player_name = gets.chomp
                        Highscore.create(name: player_name, points: score)
                        awesomest = Highscore.order('points asc').first.points
                        best = Highscore.order('points asc').first.name
                        puts""
                        puts "Highscore Table"
                        puts ""
                        tp Highscore.limit(5).order('points asc'), :name, "points"
                        puts ""
                        puts "The record holder is #{best} completing in #{awesomest} steps."
                        @player_1.destroy
                        puts ""
                        puts "Go play a fun game now, like Smash Bros. or CoD".magenta
                        
                        return false
                    end
                

            when 3
                puts "Thank you for playing, I guess.".red
                puts ""
                return false
            end
        end
    
    end


end

AdventureGame.new()
