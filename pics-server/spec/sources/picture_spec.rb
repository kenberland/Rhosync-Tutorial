require File.join(File.dirname(__FILE__),'..','spec_helper')
require "base64"

describe "Picture" do
  it_should_behave_like "SpecHelper"
  
  before(:each) do
    setup_test_for Picture,'testuser'
    @test_blob = IO.read( File.join(File.dirname(__FILE__),'../../pics-test.jpg') )
    @myData = {"caption"=>"test_caption", "image"=> Base64.encode64(@test_blob) }
  end
  
  it "should process Picture create" do
    new_id = test_create(@myData)
    create_errors.should == {}
    md[new_id].should == @myData
  end
  
  it "should process Picture query" do
    @myDeleteMe = test_query
    retval = @myDeleteMe.size.should > 0
    retval
  end
  
  it "should process Picture update" do
    pending
  end
  
  it "should process Picture delete" do
    test_query.each_pair do |key,value|
      test_delete( key )
    end
  end
end
