set :application, "wirealameda"
set :repository,  "git@github.com:purp/wirealameda.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"
default_run_options[:pty] = true


# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :scm, "git"
set :git_enable_submodules, true
set :deploy_via, :remote_cache
set :ssh_options, {:forward_agent => true}


task :staging do
  set :deploy_to, "/home/selequa/rubygoldberg.com"
  set :deployment, 'production'
  set :branch, 'master'
  set :domain, 'rubygoldberg.com'
  role :app, "rubygoldberg.com"
  role :web, "rubygoldberg.com"
  role :db,  "rubygoldberg.com", :no_release => true, :primary => true
end

task :production do
  set :deploy_to, "/home/selequa/wirealameda.org"
  set :deployment, 'production'
  set :branch, 'master'
  # set :domain, 'wirealameda.org'
  # role :app, "wirealameda.org"
  # role :web, "wirealameda.org"
  # role :db,  "wirealameda.org", :no_release => true, :primary => true
  set :domain, 'rubygoldberg.com'
  role :app, "rubygoldberg.com"
  role :web, "rubygoldberg.com"
  role :db,  "rubygoldberg.com", :no_release => true, :primary => true
end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "Build the nokogiri gem locally"
  task :rebuild_nokogiri, :roles => :app, :except => {:no_release => true } do
    run "cd #{current_path}/vendor/gems/nokogiri*/ext/nokogiri && ruby extconf.rb --with-xslt-include=/home/selequa/extras/include/ --with-xslt-lib=/home/selequa/extras/lib/ && make"
  end
  alias :before_restart :rebuild_nokogiri
end
