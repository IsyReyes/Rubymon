require 'tty-prompt'
require 'terminal-table'
require 'json'
require_relative 'validations'
require_relative 'save'
require_relative 'load'
require_relative 'stats'

class Initializing
  attr_reader :player_name, :player_main_pokemon

  def initialize
    @player_name = nil
    @player_main_pokemon = nil 
    @pokemon_nickname = nil
    @game_state = nil
  end

def welcome
  puts "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#"
  puts "#$#$#$#$#$#$#$      TEAM ROCKET RUBYMON      $#$#$#$#$#$#$#"
  puts "#$##$##$##$ ---    CLI Battle Adventure     --- #$##$##$#$#"
  puts "#$#$#$#$#$#$#$        By Isy Reyes           $#$#$#$#$#$#$#"
  puts "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#"
  puts "-----------------Please select an option-------------------"
  prompt = TTY::Prompt.new
  choices = ['New Game', 'Saved Game']
  welcome_menu_choice = prompt.select("Please select an option:", choices)
  puts "-----------------------------------------------------------"
  welcome_menu_choice

  case welcome_menu_choice
  when 'New Game'
    @game_state = new_game
  when 'Saved Game'
    Loading.display
    @game_state = Loading.load_save
    @player_name = @game_state['player_name']
    puts "\n\nWelcome back #{@player_name}! Let's save some POKEMON today!"
    selection_menu
  end
end

def new_game
  puts "Hello there! Welcome to the TEAM ROCKET central office."
  puts "My name is GIOVANNI, TEAM ROCKET LEADER!"
  puts "\nThis world is inhabited by creatures called POKEMON! For some"
  puts "people, POKEMON are pets. Others use them for fights without true purpose."
  puts "\nIn TEAM ROCKET we don't share that vision. We fight only to stop this ideology"
  puts "and practices from further spreading, helping POKEMON obtain true freedom."
  puts "First, what is your name?"
  print "\n> "

  @player_name = Validating.check_empty(gets.chomp.strip)

  puts "\nRight! So your name is #{@player_name.upcase}!"
  puts "\nYour very own quest for POKEMON freedom is about to start!"
  puts "Are you ready to take on those who would misuse POKEMON? Let's go!"
  puts "\nHere, #{@player_name.upcase}! There are 3 POKEMON here! Haha!"
  puts "These POKEMON are direct descendants from the very first POKEMON pack I rescued."
  puts "They share our values and are willing to help our cause."
  puts "\nChoose one of them to be the partner for your adventure!"

  prompt = TTY::Prompt.new
  choices = ['Bulbasaur', 'Charmander', 'Squirtle']
  @player_main_pokemon = prompt.select("Please select an option:", choices)
  @player_main_pokemon

  puts "You selected #{@player_main_pokemon}. Great choice!"
  puts "Would you like to give your POKEMON a nickname?"

  prompt = TTY::Prompt.new
  choices = ['Yes', 'No']
  @nickname_choice = prompt.select("Please select an option:", choices)

  if @nickname_choice == 'Yes'
    puts "Excellent! Please enter your #{@player_main_pokemon}'s nickname"
    print "> "
    @pokemon_nickname = gets.chomp
  elsif @nickname_choice == 'No'
    @pokemon_nickname = @player_main_pokemon
  end

  puts "Great! Looks like everything's set, let's begin your adventure!"
  puts "Raise your young #{@pokemon_nickname} by making it fight"
  puts "When you feel ready, you can challenge BROCK, the PEWTER's GYM LEADER"
  puts "-----------------------------------------------------------"
  @game_state = Saving.new_game_save(@player_name, @player_main_pokemon, @pokemon_nickname)
  @game_state
  selection_menu
end


def selection_menu
  puts "--------------------------Menu----------------------------"
  prompt = TTY::Prompt.new
  choices = ['Stats', 'Train', 'Challenge Slave Master', 'Save Game', 'Exit']
  gameplay_menu_choice = prompt.select("Please select an option:", choices)
  puts "-----------------------------------------------------------"
  case gameplay_menu_choice
  when 'Stats'
    Stats.print_stats(@game_state)
    selection_menu
    when 'Train'
    #call method for initiating a random battle
    #hashes as we have them rn won't work, change save method to add lvl key and value
  when 'Challenge Slave Master'
    #call method to battle a gym leader
    #hashes as we have them rn won't work, change save method to add lvl key and value for specific bosses
  when 'Exit'
    puts "\n\n-----------------------------------------------------------"
    puts "See you later, freedom seeker!"
    puts "-----------------------------------------------------------"
    exit
  end
end
end

game = Initializing.new
game.welcome