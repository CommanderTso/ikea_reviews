describe Item do
  let!(:item) { create(:item_with_3_reviews) }

  describe "#price" do
    it "returns the price with a '$' and two decimal places of precision" do
      expect(item.price).to eq("$149.00")
    end
  end

  describe "#calculate_average_review_score" do
    it "accurately averages all attached review scores" do
      reviews = item.reviews
      rating_sum = item.reviews.inject(0) { |sum, review| sum + review.rating }
      average = (rating_sum.to_f / reviews.count).round(2)

      expect(item.calculate_average_review_score).to eq(average)
    end
  end
end
