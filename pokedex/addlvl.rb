#This has been used already and there's no need to use it again,
#it'll be left here just as a document on the changes we did. 

require 'json'

file_content = File.read('pokemons.json')
hash = JSON.parse(file_content)

hash.transform_values! do |pokemon|
  # Rename "base_exp" to "exp"
  pokemon["exp"] = pokemon.delete("base_exp")

  # Rename "base_stats" to "stats" and add "lvl"
  stats = pokemon.delete("base_stats")
  stats["lvl"] = 1
  pokemon["stats"] = stats

  pokemon
end

json_data = JSON.pretty_generate(hash) #yes, WE'RE PRETTY <3
File.write('pokemons.json', json_data)