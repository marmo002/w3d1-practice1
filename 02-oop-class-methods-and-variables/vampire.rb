class Vampire
  @@coven = []

  # CLASS METHODS
  def self.sunrise
    @@coven.delete_if { |vampire|
      vampire.in_coffin == false && vampire.drank_blood_today == false
    }
  end

  def self.sunset
    @@coven.each do |vampire|
      vampire.go_out_get_some_blood
    end
  end

  def self.coven
    @@coven
  end

  def self.create(name, age)
    vampire = Vampire.new(name, age)
    @@coven << vampire
    vampire
  end

  # INITIALIZE METHOD
  def initialize(name, age)
    @name = name
    @age = age
    @in_coffin = true
    @drank_blood_today = false
  end

  # READERS (SETTERS)
  def in_coffin
    @in_coffin
  end

  def drank_blood_today
    @drank_blood_today
  end

  # WRITTERS (GETTERS)

  # INSTANCE METHODS
  def go_out_get_some_blood
    @in_coffin = false
    @drank_blood_today = false
  end

  def drink_blood
    @drank_blood_today = true
  end

  def go_home
    @in_coffin = true
  end
end

vampi1 = Vampire.create("martin", 185)
vampi2 = Vampire.create("jairo", 456)
vampi3 = Vampire.create("jose", 8000)
vampi4 = Vampire.create("gato", 6500)

puts
puts Vampire.coven.inspect
puts
Vampire.sunset
puts Vampire.coven.inspect
