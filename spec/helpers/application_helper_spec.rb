require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#conver_money_string_to_integer" do
    context "when params is presents" do
      let(:params){"100,000,000"}

      it "return value type integer" do
        expect(helper.conver_money_string_to_integer(params)).to eq 100000000
      end
    end
  end
end
