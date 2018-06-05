require_relative '../models/entry' #loads entry model for testing

# #1 standard first line of RSpec tests; tells us that this is a spec file that tests "entry"
  RSpec.describe Entry do
    # #2 .describe gives structure; communicates that the specs test the Entry attributes
    describe "attributes" do
      let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')}
      # #3 each "it" represents a unique test
      it "responds to name" do
        expect(entry).to respond_to(:name) #checks whether entry.name is valid code
      end

      it "reports its name" do
        expect(entry.name).to eq('Ada Lovelace')
      end

      it "responds to phone number" do
        expect(entry).to respond_to(:phone_number)
      end

      it "reports its phone number" do
        expect(entry.phone_number).to eq('010.012.1815')
      end

      it "responds to email" do
        expect(entry).to respond_to(:email)
      end

      it "reports its email" do
        expect(entry.email).to eq('augusta.king@lovelace.com')
      end
    end
    # #5 new describe bloc to separate the to_s test from the initializer test
    describe "#to_s" do
      it "prints an entry as a string" do
        entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
        expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
    # #6 we use eq to check that to_s returns a string equal to expected_string
        expect(entry.to_s).to eq(expected_string)
      end
    end

end
