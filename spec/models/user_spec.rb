require 'rails_helper'

RSpec.describe User do
  let(:user) { build(:user) }

  describe 'associations' do
    it { should have_many(:habits) }
  end
  
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
      user.update_attribute :password_confirmation, Faker::Internet.password(min_length: 6, max_length: 6)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "when passwords is less than 6 characters long" do
      invalid_user = build(:user, password: Faker::Internet.password(min_length: 1, max_length: 5))
      invalid_user.valid?
      expect(invalid_user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
    it "when phone number is less than 12 digits long" do
      user.update_attribute :phone, Faker::Number.number(digits: 5) 
      user.valid?
      expect(user.errors[:phone]).to include("is too short (minimum is 12 characters)")
    end
    it "when phone number is more than 16 digits long" do
      user.update_attribute :phone, Faker::Number.number(digits: 17) 
      user.valid?
      expect(user.errors[:phone]).to include("is too long (maximum is 16 characters)")
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
