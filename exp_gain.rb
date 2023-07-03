class Leveling

  def self.add_exp(game_state, training_battle)

  pokemon_exp = JSON.parse(File.read("./pokedex/pokemons.json"))["exp"]

  