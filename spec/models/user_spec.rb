require 'rails_helper'

RSpec.describe User do
  let(:user) { build(:user) }

  describe "is invalid" do
    it "without email" do
      user.update_attribute :email, ""
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "without first name" do
      user.update_attribute :first_name, nil
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end
    it "without last name" do
      user.update_attribute :last_name, nil
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end
    it "without phone" do 
      user.update_attribute :phone, nil
      user.valid?
      expect(user.errors[:phone]).to include("can't be blank")
    end
    it "without password" do
      user.update_attribute :password, nil
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    it "when passwords don't match" do
      user.update_attribute :password_confirmation, Faker::Internet.password(min_length: 6)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "if the email is already taken" do
      email = Faker::Internet.unique.safe_email 
      user_one = create(:user, email: email)
      user_two = build(:user, email: email)
      user_two.valid?
      expect(user_two.errors[:email]).to include("has already been taken")
    end
  end

  it "is valid with first name, last name, phone number, email and password" do
    valid_user = build(:user)
    expect(valid_user).to be_valid
  end
end
