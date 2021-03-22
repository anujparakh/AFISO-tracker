require "rails_helper"

RSpec.describe "Transactions Page", type: :feature do
  before :all do
    Transaction.new(transaction_amount: 1010, transaction_type: "Type1", transaction_date: DateTime.now, officer_id: Officer.last.id).save
  end

  before(:each) do
    @admin = Admin.create(email: "test@test.com")
    sign_in @admin
  end

  # MUST test each page to make sure it's password protected
  describe "Password Protected" do
    it "shows the password page" do
      visit "home/index"
      click_on "Log Out"
      expect(page).to have_content("Sign in with Google")

    end
  end

  # Check to make sure each page works
  describe "Index Page" do
    it "logs in and shows the transactions index page" do
      visit transactions_path
      expect(page).to have_content("Transactions")
    end
  end

  describe "Create Page" do
    it "logs in and visits the page" do
      visit new_transaction_path
      expect(page).to have_content("New Transaction")
    end

    it "tries to create a new valid transaction" do
      visit new_transaction_path
      fill_in "transaction_transaction_amount", with: 50
      select Officer.last.email, :from => "transaction_officer_id"

      click_button("Add Transaction")
      expect(page).to have_content("Transactions")
    end

    it "tries to create a new invalid transaction" do
      visit new_transaction_path
      click_button("Add Transaction")
      expect(page).to have_content("Invalid")
    end

    it "tries to create a new invalid transaction without transaction amount" do
      visit new_transaction_path
      select Officer.last.email, :from => "transaction_officer_id"
      click_button("Add Transaction")
      expect(page).to have_content("Invalid")
    end
  end

  describe "Edit Transaction" do
    it "opens edit page for a transaction" do
      visit edit_transaction_path(Transaction.last.id)
      expect(page).to have_content("Update")
    end

    it "opens edit page for a transaction and changes the name" do
      visit edit_transaction_path(Transaction.last.id)
      fill_in "transaction_transaction_amount", with: 123456
      click_button("Update Transaction")

      expect(page).to have_content("123456")
    end

    it "opens edit page for a member and changes to an invalid transaction" do
      visit edit_transaction_path(Transaction.last.id)
      fill_in "transaction_transaction_amount", with: ""
      click_button("Update Transaction")

      expect(page).to have_content("Update")
    end

  end

  describe "Show Transaction" do
    it "opens show page for a transaction" do
      visit transaction_path(Transaction.last.id)
      expect(page).to have_content("Transaction")
    end
  end

  describe "Delete Transaction" do
    it "opens delete page for a transaction" do
      visit delete_transaction_path(Transaction.last.id)
      expect(page).to have_content("Delete")
    end

    it "Deletes a Transaction" do
      visit delete_transaction_path(Transaction.last.id)
      click_button("Delete Transaction")
      expect(page).to have_content("Transactions")
    end
  end
end
