require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }

  describe "is invalid" do
    it "without email" do
      user.update_attribute :email, ""
      user.valid?
      expect(user.errors[:email].to include("can't be blank"))
    end
    it "without first name" do
      user.update_attribute :first_name, nil
      user.valid?
      expect(user.errors[:first_name].to include("can't be blank"))
    end
    it "without last name" do
      user.update_attribute :last_name, nil
      user.valid?
      expect(user.errors[:last_name].to include("can't be blank"))
    end
     it "without phone" do 
      user.update_attribute :phone, nil
      user.valid?
      expect(user.errors[:phone].to include("can't be blank"))
    end
     it "without password" do
      user.update_attribute :password, nil
      user.valid?
      expect(user.errors[:password].to include("can't be blank"))
     end
  end

  describe "is valid" do
    it "with first name, last name, phone number, email and password" do
      valid_user = build(:user)
      expect(valid_user).to be_valid
    end
  end
end
