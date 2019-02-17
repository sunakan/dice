require 'rails_helper'

RSpec.describe User, type: :model do
  describe "email属性" do
    context "Eメールアドレスがnil" do
      it "validationが通らない" do
        user = User.new(name: "test", email: nil, password: "test")
        expect(user).not_to be_valid
      end
    end
    context "Eメールアドレスが重複" do
      it "validationが通らない" do
        User.create(name: "test", email: "test@example.com", password: "test")
        user = User.new(name: "test", email: "test@example.com", password: "test")
        expect(user).not_to be_valid
      end
    end
  end
end
