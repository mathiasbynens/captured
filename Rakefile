require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "captured"
    gem.summary = "Quick screenshot sharing for OS X"
    gem.description = "Because <shift>-<command>-4 is the single most useful shorcut in Macdom"
    gem.email = "csexton@gmail.com"
    gem.homepage = "http://github.com/csexton/captured"
    gem.authors = ["Christopher Sexton"]
    gem.rubyforge_project = 'captured'
    gem.add_dependency('imgur')
    gem.add_dependency('net-scp')
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.files = FileList["VERSION", "[A-Z]*.*", "{bin,etc,lib,features,resources,spec}/**/*"]
    gem.post_install_message = <<MESSAGE

   =========================================================================

             Thanks for installing Captured! You can now run:

   captured --install      to setup launchd to run captured in the background

    When you install an example config file to ~/.captured.yml, which has a
    few examples of possible configuration types.

   =========================================================================

MESSAGE
  end

  Jeweler::GemcutterTasks.new
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

# These are new tasks
begin
  require 'rake/contrib/sshpublisher'
  namespace :rubyforge do

    desc "Release gem and RDoc documentation to RubyForge"
    task :release => ["rubyforge:release:gem", "rubyforge:release:docs"]

    namespace :release do
      desc "Publish RDoc to RubyForge."
      task :docs => [:rdoc] do
        config = YAML.load(
            File.read(File.expand_path('~/.rubyforge/user-config.yml'))
        )

        host = "#{config['username']}@rubyforge.org"
        remote_dir = " /var/www/gforge-projects/captured/"
        local_dir = 'rdoc'

        Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
      end
    end
  end
rescue LoadError
  puts "Rake SshDirPublisher is unavailable or your rubyforge environment is not configured."
end


require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--colour', '--format specdoc', '--loadby mtime', '--reverse']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

desc "Release to rubyforge and gemcutter"
  task :doit => ['gemcutter:release', 'rubyforge:release:gem'] do
    puts "Released"
  end


task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "captured #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

