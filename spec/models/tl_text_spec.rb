require 'spec_helper'

describe "TlText" do

  context "valid input" do
    it "creates a record with content saved in the data field" do
      tl_text = TlText.create_from_form({"content" => "This is a test..."})
      expect(tl_text).to be_valid
      expect(tl_text.content).to eq("This is a test...")
    end
  end

  context "invalid input" do
    it "validates presence of content" do
      tl_text = TlText.create_from_form("")
      expect(tl_text).to_not be_valid
    end

    it "requires the length be less than 512 chars" do
      tl_text = TlText.create_from_form({ "content" => "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?" })
      expect(tl_text).to_not be_valid
    end

    it "prevents unspecifed attributes from being saved" do
      tl_text = TlText.create_from_form({"content" => "test", "wibble" => "wibble"})
      expect(tl_text.data).to eq({"content" => "test"})
    end
  end

end
