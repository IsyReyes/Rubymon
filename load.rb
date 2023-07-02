
class Loading

  def self.display
    save_files = Dir.glob('saves/*.json')
  
    if save_files.empty?
      rows = [["There are no saved files yet!"]]
    else
    rows = save_files.map do |file|
      game_state = JSON.parse(File.read(file))
      save_name = File.basename(file, '.json')
  
      player_name = game_state['player_name']
      pokemon_species = game_state['player_main_pokemon']['species']
      pokemon_nickname = game_state['pokemon_nickname']
      pokemon_level = game_state['player_main_pokemon']['stats']['lvl']
  
      [save_name, player_name, "#{pokemon_species} - #{pokemon_nickname}", pokemon_level]
    end
  end

    table = Terminal::Table.new title: 'Saved Files' do |t|
      if save_files.empty?
        t.rows = rows
      else
        t.headings = ['Save Name', 'Player Name', 'Pokemon', 'Lvl']
        t.rows = rows
      end
    end
    puts table
  end

  def self.load_save
    prompt = TTY::Prompt.new
    save_files = Dir.glob('saves/*.json').map { |file| File.basename(file, '.json') }
  
    if save_files.empty?
      puts "-----------------------------------------------------------"
      save_files << "Go Back"
      chosen_file = prompt.select("Return to the main menu:", save_files)
      puts "-----------------------------------------------------------"
      return Initializing.new.welcome if chosen_file == "Go Back"
    end
    
    save_files
    chosen_file = prompt.select("Select a save file:", save_files)

    game_state = JSON.parse(File.read("saves/#{chosen_file}.json"))
    game_state
  end
end

