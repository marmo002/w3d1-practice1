class Product

  # CLASS METHODS
  @@standard = 0.13
  @@tax_exempt = 0
  @@imported = 0.25

  # INITIALIZE METHODS
  def initialize(name, base_price, tax_rate)
    @name = name
    @base_price = base_price

    case tax_rate
    when "standard"
      @tax_rate = @@standard
    when "exempt"
      @tax_rate = @@tax_exempt
    when "imported"
      @tax_rate = @@imported
    end
  end

  # READERS
  def name
    @name
  end

  def base_price
    @base_price
  end

  def tax_rate
    @tax_rate
  end

  # WRITTERS

  #INSTANCE METHODS
  def total_price
    (@base_price * (1 + @tax_rate)).round(2)
  end

end
