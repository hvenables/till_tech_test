require_relative '../../lib/app/till.rb'

describe Till do
  subject { Till.new('hipstercoffee.json') }

  describe 'displays cafe info' do
    it 'should return the name of the cafe' do
      expect(subject.show_name).to eq('The Coffee Connection')
    end

    it 'should return the phone number of the cafe' do
      expect(subject.show_number).to eq("16503600708")
    end

    it 'should return the address of the cafe' do
      expect(subject.show_address).to eq("123 Lakeside Way")
    end

    it 'should add items to the order' do
      subject.add_to_order("Tea", 3)
      expect(subject.instance_variable_get(:@order)).to eq({"Tea" => 3})
    end

    it 'should return line totals' do
      subject.add_to_order("Tea", 1)
      subject.add_to_order("Cafe Latte", 1)
      expect(subject.line_total).to eq([3.65, 4.75])
    end

    it 'should return the total' do
      subject.add_to_order("Tea", 1)
      subject.add_to_order("Cafe Latte", 1)
      expect(subject.total).to eq(8.40)
    end

    it 'should add discount on orders over $50' do
      subject.add_to_order("Cafe Latte", 7)
      subject.add_to_order("Tea", 7)
      expect(subject.total).to eq(55.86)
    end

    it 'should calculate tax' do
      subject.add_to_order("Cafe Latte", 1)
      subject.add_to_order("Tea", 1)
      expect(subject.calc_tax).to eq(0.73)
    end

    it 'can return the change' do
      subject.add_to_order("Tea", 1)
      subject.add_to_order("Cafe Latte", 1)
      subject.total
      expect(subject.calc_change(10)).to eq(1.6)
    end
  end
end
