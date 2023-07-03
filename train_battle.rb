class Battle

  def self.rescue_battle(game_state)
    slavers = JSON.parse(File.read("./slavers/slavers.json"))["slavers"]["names"]
    pokemons = JSON.parse(File.read("./pokedex/pokemons.json"))

    slaver_name = slavers.sample
    @opponent_pokemon_name, @opponent_pokemon_data = pokemons.to_a.sample
    @opponent_pokemon_level = calculate_opponent_level(game_state)

    player_name = game_state['player_name']

    puts "#{player_name} ambushes POKEMON slaver #{slaver_name}"
    puts "#{slaver_name} has a #{@opponent_pokemon_name} lvl #{@opponent_pokemon_level}"

    prompt = TTY::Prompt.new
    choices = ['Attempt Rescue', 'Wait For Now...']
    battle_choice = prompt.select("What will you do?", choices)

    case battle_choice
    when 'Attempt Rescue'
      puts "Let's rescue these POKEMON!"
    when 'Wait For Now...'
      puts "-----------------------------------------------------------"
      puts "Better be patient now..."
      Initializing.new.selection_menu(game_state)
    end
  end

  #this ♪method♪ will calculate the opponent's pkm lvl and pump it up around 6 lvls from the players'
  #(3 down, 3 up max) ♥
  def self.calculate_opponent_level(game_state)
    player_level = game_state["player_main_pokemon"]["stats"]["lvl"]

    opponent_level = rand(player_level - 3..player_level + 3)
    opponent_level = 1 if opponent_level < 1
    
    opponent_level
  end
end
