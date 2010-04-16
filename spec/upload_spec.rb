require "spec_helper"

describe "uploading a file" do
  it "greets you" do
    response = request("/")
    response.should be_successful
  end

  it "accepts an upload" do
    filename = "foo.tgz"

    response = multipart_post("/upload", {:file => File.open(filename)}, 'HTTP_ACCEPT' => 'application/json' )
    response.should be_successful
    File.read(filename).should eql(File.read(File.join(Dir.tmpdir, filename)))
  end
end
