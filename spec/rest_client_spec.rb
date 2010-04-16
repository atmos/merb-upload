require "pp"
require "rest_client"

describe "hitting the appserver" do
  it "uploads files from rest client" do
    response = RestClient.post 'http://localhost:4000/upload', {:file => File.new('foo.tgz')}
    response.code.should eql(200)
  end
end
