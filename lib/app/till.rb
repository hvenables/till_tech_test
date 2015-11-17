require 'json'

class Till

  def initialize(menu)
    file = File.read(menu)
    @data_hash = JSON.parse(file).first
    @order = {}
    prices
  end

  def show_name
    @cafe_name = @data_hash["shopName"]
  end

  def show_number
    @cafe_number = @data_hash["phone"]
  end

  def show_address
    @cafe_address = @data_hash["address"]
  end

  def add_to_order(item, quantity)
    if @prices[item]
      @order[item] = quantity
    end
  end

  def line_total
    @line_total = @order.map do |item, quantity|
      @prices[item] * quantity
    end
  end

  def total
    line_total
    @total = @line_total.inject(:+)
    if @total >= 50
      @total = @total * 0.95
    end
    @total = sprintf "%.2f", @total
    @total = @total.to_f
  end

  def calc_tax
    total
    @tax = (@total * 0.0864)
    @tax = sprintf "%.2f", @tax
    @tax.to_f
  end

  def calc_change(customer_cash)
    @change = customer_cash - @total
    @change = sprintf "%.2f", @change
    @change.to_f
  end

  def muffin_discount
  end

  private

  def prices
    @prices = @data_hash["prices"].first
  end
end

