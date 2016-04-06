describe Item do
	before(:each) do
		FactoryGirl.create(:item)
	end

  describe "#price" do
    it "returns the price with two decimal places of precision" do
			item = Item.last
			expect(item.price).to eq("149.00")
    end
  end
end
