require "rails_helper"

RSpec.describe User, type: :model do
  describe "email属性" do
    context "Eメールアドレスがnil" do
      it "validationが通らない" do
        user = FactoryBot.build(:user, email: nil)
        expect(user).not_to be_valid
      end
    end

    context "Eメールアドレスが重複" do
      it "validationが通らない" do
        email = "test@example.com"
        FactoryBot.create(:user, email: email)
        user = FactoryBot.build(:user, email: email)
        expect(user).not_to be_valid
      end
    end
  end
end
