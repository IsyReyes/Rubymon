
class Stats
  def self.print_stats(game_state)
    pokemon = game_state['player_main_pokemon']
    pokemon_nickname = game_state['pokemon_nickname']

    nickname_row = pokemon['species'] != pokemon_nickname ? [['Nickname', pokemon_nickname]] : []

    rows = [['Species', pokemon['species']]] + nickname_row + pokemon['stats'].map do |stat_name, value|
      [stat_name, value]
    end

    table = Terminal::Table.new title: 'Partner Stats', rows: rows
    puts table
  end
end