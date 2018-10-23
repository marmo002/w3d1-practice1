class BankAccount
  @@interest_rate = 0.2
  @@accounts = []

  #Class methods
  def self.accounts
    @@accounts
  end

  def self.total_funds

    @@accounts.map { |account|
      account.balance
    }.reduce(:+)

  end

  def self.interest_time
    @@accounts.each { |account|
      new_balance = account.balance * (1 + @@interest_rate)
      account.balance = new_balance
    }
  end

  def self.create
    new_account = BankAccount.new
    @@accounts << new_account
    new_account
  end

  def initialize
    @balance = 0
  end

  #Readers (Getters)
  def balance
    @balance
  end

  #Writters (Setters)
  def balance=(new_balance)
    @balance = new_balance
  end

  #Other methods
  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end



end

my_account = BankAccount.create
your_account = BankAccount.create
puts my_account.balance # 0
puts BankAccount.total_funds # 0
my_account.deposit(200)
your_account.deposit(1000)
puts my_account.balance # 200
puts your_account.balance # 1000
puts BankAccount.total_funds # 1200
BankAccount.interest_time
puts my_account.balance # 202.0
puts your_account.balance # 1010.0
puts BankAccount.total_funds # 1212.0
my_account.withdraw(50)
puts my_account.balance # 152.0
puts BankAccount.total_funds # 1162.0
