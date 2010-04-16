Bundler.setup(:default)
Bundler.require(:default)

use_test :rspec
use_template_engine :erb

Merb::Config.use { |c|
  c[:framework]           = { :public => [Merb.root / "public", nil] }
  c[:session_store]       = 'none'
  c[:exception_details]   = true
  c[:log_level]           = :debug # or error, warn, info or fatal
  c[:log_file]          = Merb.root / "merb.log"

  c[:reload_classes]   = false
  c[:reload_templates] = false
}

Merb::Router.prepare do
  match('/').to(:controller => 'upload', :action =>'index')
  match('/upload').to(:controller => 'upload', :action =>'upload', :method => :post)
end

class Upload < Merb::Controller
  def index
    <<-EOF
      <form action="/upload" method="POST" enctype="multipart/form-data">
        <input type="file" name="file"><br>
        <input type="submit">
      </form>
    EOF
  end

  def upload(file)
    filename = File.join(Dir.tmpdir, file['filename'])
    File.open(filename, 'w') do |fp|
      fp.write file['tempfile'].read
    end
    {:success => true}.to_json
  end
end
