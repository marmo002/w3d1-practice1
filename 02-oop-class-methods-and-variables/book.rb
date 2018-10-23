class Book
  @@on_shelf = []
  @@on_loan = []

  #CLASS METHODS
  def self.available
    @@on_shelf
  end

  def self.borrowed
    @@on_loan
  end

  def self.browse
    @@on_shelf.sample
  end

  def self.overdue
    @@on_loan.select do |book|
      book.due_date < Time.now
    end
  end

  def self.find(search)
    results1 = @@on_shelf.select do |book|
      book.title == search || book.author == search || book.isbn == search
    end

    results2 = @@on_loan.select do |book|
      book.title == search || book.author == search || book.isbn == search
    end

    results1 + results2
  end

  def self.find_genre(genre)
    @@on_shelf.select do |book|
      book.genre == genre
    end
  end

  def self.create(title, author, genre, isbn)
    new_book = Book.new(title, author, genre, isbn)
    @@on_shelf << new_book
    new_book
  end

  def initialize(title, author, genre, isbn)
    @title = title
    @author = author
    @genre = genre
    @isbn = isbn
  end

  #READERS (getter)
  def title
    @title
  end

  def author
    @author
  end

  def isbn
    @isbn
  end

  def due_date
    @due_date
  end

  def on_hold
    @on_hold
  end

  def genre
    @genre
  end

  #WRITTERS (Setters)
  def due_date=(due)
    @due_date = due
  end

  #INSTANCE METHODS
  def current_due_date
    Time.new(Time.now.year, Time.now.month, Time.now.day) + (60*60*24*7)
  end

  def lend_out?
    @@on_loan.include?(self)
  end

  def put_on_hold
    @on_hold = true
  end

  def put_off_hold
    @on_hold = false
  end

  def borrow
    if self.lend_out?
      self.put_on_hold
      false
    else
      self.due_date = current_due_date
      @@on_loan << @@on_shelf.delete(self)
      true
    end
  end

  def return_to_library
    if self.lend_out?
      @@on_shelf << @@on_loan.delete(self)
      self.due_date = nil
      true
    else
      false
    end
  end

  def renew
    if on_hold
      false
    else
      self.due_date += (60*60*24*2)
    end
  end

end

sister_outsider = Book.create("Sister Outsider", "Audre Lorde", 'comedy', "9781515905431")
aint_i = Book.create("Ain't I a Woman?", "Bell Hooks", 'horror', "9780896081307")
if_they_come = Book.create("If They Come in the Morning", "Angela Y. Davis", 'comedy', "0893880221")

puts Book.browse.inspect
puts Book.browse.inspect
puts Book.browse.inspect
puts
puts "Books available:"
puts Book.available.inspect
puts
puts "Books borrowed:"
puts Book.borrowed.inspect
puts
puts sister_outsider.lend_out?
puts sister_outsider.borrow
puts
puts "Books borrowed:"
puts Book.borrowed.inspect
puts
puts sister_outsider.lend_out?
puts "testing on_hold"
puts sister_outsider.borrow
puts
puts "Due date"
puts sister_outsider.due_date
puts sister_outsider.renew
puts sister_outsider.due_date
puts
puts "Books available:"
puts Book.available.inspect
puts
puts "Books borrowed:"
puts Book.borrowed.inspect
puts "Looking for If They Come..."
puts Book.find('If They Come in the Morning').inspect
puts
puts "Books overdue:"
puts Book.overdue.inspect
puts
puts sister_outsider.return_to_library
puts sister_outsider.lend_out?
puts
puts "Books available:"
puts Book.available.inspect
puts
puts "Books borrowed:"
puts Book.borrowed.inspect
puts
puts Book.find_genre('comedy').inspect
