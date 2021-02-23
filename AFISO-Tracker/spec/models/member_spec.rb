require "rails_helper"

RSpec.describe Member, :type => :model do
  subject {
    described_class.new(name: "John Doe", email: "johndoe@gmail.com")
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with an invalid email" do
      subject.email = "fakeemail.com"
      expect(subject).to_not be_valid
    end
  end
end
