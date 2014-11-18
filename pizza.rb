class Pizza
  attr_reader :name, :description, :time_baked
  attr_accessor :toppings

  def initialize(name, description)
    @name = name
    @description = description
    @time_baked = 0
    @toppings = []
  end

  def add_topping(type_of_topping)
    @toppings << type_of_topping
  end

  def required_bake_time
    total_bake_time = 15
    @toppings.each do |topping|
      total_bake_time += topping.required_bake_time
    end
    bake_time_in_seconds = total_bake_time * 60
  end

  def bake(time_baked)
    @time_baked += time_baked
    @toppings.each do |topping|
      topping.time_baked += time_baked
    end
  end

  def baked?
    bake_time_in_minutes = required_bake_time/60
    if @time_baked == bake_time_in_minutes
      true
    else
      false
    end
  end

  def unfinished_toppings
    @unfinished_toppings = []
    @toppings.map do |topping|
      @unfinished_toppings << topping if topping.required_bake_time > topping.time_baked
    end
    @unfinished_toppings
  end

  def finished_toppings
    @finished_toppings = []
    @toppings.map do |topping|
      @finished_toppings << topping if topping.required_bake_time < topping.time_baked
    end
    @finished_toppings
  end
end


class Topping
  attr_reader :name, :required_bake_time
  attr_accessor :time_baked

  def initialize(name, required_bake_time)
    @name = name
    @required_bake_time = required_bake_time
    @time_baked = 0
  end

  def bake(time_baked)
    @time_baked += time_baked
  end

  def baked?
    if @time_baked == @required_bake_time
      true
    else
      false
    end
  end

end
