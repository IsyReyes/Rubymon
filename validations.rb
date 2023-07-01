class Validating

  #Rocket recruit name validation, prevents empty name
  def self.check_empty(input)
  while input.empty?
    puts "You can't leave your name empty! Please tell me how you'd like to be called."
    print "> "
    input = gets.chomp.strip
  end
  input
end

#New game save validations, prevents empty file name, sets length and checks for valid charachters
def self.check_file_name(input)
  while input.empty? || input.length > 10 || (input =~ /\A\w+\z/).nil?
    if input.empty?
      puts "You can't leave this field empty! Please try again."
    elsif input.length > 10
      puts "The filename is too long! It must be 10 characters or less. Please try again."
    else
      puts "Invalid characters used! Please enter a valid filename."
    end
    print "> "
    input = gets.chomp.strip
  end
  input
end
end