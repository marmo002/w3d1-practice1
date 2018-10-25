class Zombie

  @@horde              =   []
  @@plague_level       =   10
  @@max_speed          =   5
  @@max_strength       =   8
  @@default_speed      =   1
  @@default_strength   =   1

  # CLASS METHODS
  def self.all
    @@horde
  end

  def self.sample
    @@horde.sample
  end

  def self.deadliest_zombie
    if all.length == 0
      "Zombies extinct"
    elsif all.length == 1
      all[0]
    else
      fastest = @@horde.max(2) { |a, b|
        a.speed <=> b.speed
      }.min {|a, b| a.speed <=> b.speed }.speed

      strongest = @@horde.max(2) { |a, b|
        a.strength <=> b.strength
      }.min { |a, b| a.strength <=> b.strength }.strength

      @@horde.select { |e|
        e.speed >= fastest && e.strength >= strongest
      }
    end

  end

  def self.new_day
    some_die_off
    spawn
    increase_plague_level
    @@horde
  end

  def self.some_die_off
    no_zombies = @@horde.length + 1
    no_zombies_to_die = rand(no_zombies)# will return a number from 0..count of zombies
    dead_zombies = []
    no_zombies_to_die.times do
      zombie = @@horde.sample
      dead_zombies << @@horde.delete(zombie)
    end
    dead_zombies
  end

  def self.spawn
    # get a random number max = @@plague_level
    no_of_zombies = rand(1..@@plague_level)

    # create that number of zombies
    no_of_zombies.times do
      # use @@max_speed and @@max_strength got get random values per zombie
      speed = rand(1..@@max_speed)
      strength = rand(1..@@max_strength)

      # create and add each zombie to horde
      Zombie.create(speed, strength)
    end

    @@horde
  end

  def self.increase_plague_level
    increase_by = rand(@@plague_level + 1) # will return number between 0..2
    @@plague_level += increase_by
  end

  def self.create(speed, strength)
    new_zombie = Zombie.new(speed, strength)
    @@horde << new_zombie
    new_zombie
  end

  def initialize(speed, strength)

    if speed > @@max_speed
      @speed = @@default_speed
    else
      @speed = speed
    end

    if strength > @@max_strength
      @strength = @@default_strength
    else
      @strength = strength
    end

  end

  # READERS (GETTERS)
  def speed
    @speed
  end

  def strength
    @strength
  end

  # WRITTERS (SETTERS)

  # INSTANCE METHODS
  def encounter
    if outrun_zombie?
      "You scaped"
    else
      if survive_attack?
        # become zombie
        speed = self.speed
        strength = self.strength
        Zombie.create(speed, strength)
        "You a zombie now brah!"
      else
        "You died"
      end
    end
  end

  def outrun_zombie?
    person_speed = rand(@@max_speed + 1)
    person_speed > self.speed ? true : false
  end

  def survive_attack?
    person_strength = rand(@@max_strength + 1)
    person_strength > self.strength ? true : false
  end

end # end of Zombie class

puts "Spawn some zombies please"
puts Zombie.spawn.inspect
puts "Zombies count: #{Zombie.all.length}"
puts
puts "all zombies:"
puts Zombie.all
puts
puts "New day"
puts Zombie.new_day.inspect
puts
puts "Zombies count: #{Zombie.all.length}"
# puts
# puts "Dead zombies:"
# puts Zombie.some_die_off
puts
puts "Zombies count: #{Zombie.all.length}"
puts
zombie = Zombie.sample
puts zombie.inspect
puts zombie.encounter.inspect
puts
puts "all zombies:"
puts Zombie.all.inspect
puts
puts "Deadliest Zombie:"
puts Zombie.deadliest_zombie.inspect
