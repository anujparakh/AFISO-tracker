require 'rails_helper'

RSpec.describe Admin, type: :model do
    describe "From Google Method" do
        it "Give a valid email" do
            expect(Admin.from_google(email: "anuj@anujinfotech.com", full_name: "Invalid Person", uid: 1, avatar_url: "something")).to_not be nil
        end

        it "Give an invalid email" do
            expect(Admin.from_google(email: "invalid@gmail.com", full_name: "Invalid Person", uid: 1, avatar_url: "something")).to be nil
        end
    end
end
