require_relative 'pizza'

describe 'Pizza' do
  let(:pizza) {Pizza.new("pepperoni",
                        "The best pepperoni pizza in town. All the pepperoni. EVER!")}
  let(:pepperoni) {Topping.new('pepperoni', 3)}
  let(:sausage) {Topping.new('sausage', 6)}

  context 'when initialized' do
    it 'creates a Pizza object' do
      expect(pizza).to be_an_instance_of Pizza
    end

    it 'requires 2 parameters' do
      expect{Pizza.new}.to raise_error(ArgumentError)
    end

    it 'has a name' do
      expect(pizza.name).to eq("pepperoni")
    end

    it 'has a description' do
      expect(pizza.description).to eq("The best pepperoni pizza in town. All the pepperoni. EVER!")
    end

    it 'has an timed baked attribute' do
      expect(pizza.time_baked.class).to eq(Fixnum)
    end

    it 'has a default time_baked at 0' do
      expect(pizza.time_baked).to eq(0)
    end

    it 'has a toppings array' do
      expect(pizza.toppings).to be_an_instance_of Array
    end

    it 'has an empty toppings array' do
      expect(pizza.toppings.length).to eq(0)
    end
  end

  describe '#add_topping' do

    context 'when called' do
      it 'requires 1 parameter' do
        expect{pizza.add_topping}.to raise_error(ArgumentError)
      end

      it 'adds a topping object to Pizza' do
        pizza.add_topping(pepperoni)
        expect(pizza.toppings.first).to be_an_instance_of Topping
      end
    end
  end

  describe '#required_bake_time' do

    context 'when called' do
      it 'requires 0 parameters' do
        expect{pizza.required_bake_time(10)}.to raise_error(ArgumentError)
      end

      it 'returns an integer' do
        expect(pizza.required_bake_time.class).to be(Fixnum)
      end

      it 'returns the correct time in seconds' do
        pizza.add_topping(pepperoni)
        expect(pizza.required_bake_time).to eq(1080)
      end
    end
  end

  describe '#bake' do

    context 'when called' do
      it 'requires 1 parameter' do
        expect{pizza.bake}.to raise_error(ArgumentError)
      end

      it 'increases the time_baked attribute for Pizza' do
        pizza.add_topping(pepperoni)
        pizza.bake(1)
        expect(pizza.time_baked).to eq(1)
      end

      it 'increases the time_baked attribe for all Toppings' do
        pizza.add_topping(pepperoni)
        pizza.bake(1)
        expect(pizza.toppings.first.time_baked).to eq(1)
      end
    end
  end

  describe '#baked?' do

    context 'when called' do
      it 'returns a boolean' do
        expect(pizza.baked?.class).to eq(FalseClass)
      end

      it 'returns true when baked' do
        pizza.add_topping(pepperoni)
        pizza.bake(18)
        expect(pizza.baked?).to be(true)
      end
    end
  end

  describe '#unfinished_toppings' do

    context 'when called' do
      it 'returns an array' do
        expect(pizza.unfinished_toppings).to be_an_instance_of Array
      end

      it 'returns all Topping objects that have not finished cooking' do
        pizza.add_topping(pepperoni)
        pizza.add_topping(sausage)
        pizza.bake(1)
        expect(pizza.unfinished_toppings).to eq([pepperoni, sausage])
      end

      it 'will not return cooked toppings' do
        pizza.add_topping(pepperoni)
        pizza.add_topping(sausage)
        pizza.bake(4)
        expect(pizza.unfinished_toppings).to eq([sausage])
      end
    end
  end

  describe '#finished_toppings' do

    context 'when called' do
      it 'returns an array' do
        expect(pizza.finished_toppings).to be_an_instance_of Array
      end

      it 'returns all Topping objects that have finished cooking' do
        pizza.add_topping(pepperoni)
        pizza.bake(5)
        expect(pizza.finished_toppings).to eq([pepperoni])
      end

      it 'will not return uncooked toppings' do
        pizza.add_topping(pepperoni)
        pizza.add_topping(sausage)
        pizza.bake(1)
        expect(pizza.finished_toppings).to eq([])
      end
    end
  end

end


describe 'Topping' do
  let(:topping) {Topping.new('sausage', 4)}

  describe '#initialize' do

    context 'when initalized' do
      it 'creates a Topping object' do
        expect(topping).to be_an_instance_of Topping
      end

      it 'requires 2 parameters' do
        expect{Topping.new}.to raise_error(ArgumentError)
      end

      it 'has a name' do
        expect(topping.name).to eq('sausage')
      end

      it 'has a required_bake_time' do
        expect(topping.required_bake_time).to eq(4)
      end

      it 'has a time_baked attribute whos default is 0' do
        expect(topping.time_baked).to eq(0)
      end
    end
  end

  describe '#bake' do

    context 'when called' do
      it 'takes 1 parameter' do
        expect{topping.bake}.to raise_error(ArgumentError)
      end

      it 'increases the time_baked attribute' do
        topping.bake(1)
        expect(topping.time_baked).to eq(1)
      end
    end
  end

  describe '#baked?' do

    context 'when called' do
      it 'returns a boolean' do
        expect(topping.baked?.class).to eq(FalseClass)
      end

      it 'returns true when baked' do
        topping.bake(4)
        expect(topping.baked?).to be(true)
      end
    end
  end

end
