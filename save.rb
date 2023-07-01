class Saving

  def self.new_game_save(player_name, player_main_pokemon, pokemon_nickname)
    pokemons = JSON.parse(File.read("./pokedex/pokemons.json"))
    chosen_pokemon = pokemons[player_main_pokemon]

    game_state = {
      player_name: player_name,
      player_main_pokemon: chosen_pokemon,
      pokemon_nickname: pokemon_nickname
    }

    puts "Please enter a name for your save file (10 characters limit):"
    file_name_input = gets.chomp.strip
    file_name = Validating.check_file_name(file_name_input)

    if File.exist?("#{file_name}.json")
      puts "A save file with this name already exists. Please choose a different name."
      self.new_game_save(player_name, player_main_pokemon, pokemon_nickname)
    else
      File.open("saves/#{file_name}.json", "w") do |f|
        f.write(game_state.to_json)
      end
      puts "-----------------------------------------------------------"
      puts "Game has been saved as #{file_name}!"
    end
  end
end