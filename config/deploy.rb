$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, "squat-cafe"
set :repository,  "git://github.com/izzm/Squat-cafe.git"

set :scm, :none
set :repository, "/home/vizoria/squat/rails_shop"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user
set :use_sudo, false

role :web, "62.76.191.136"                          # Your HTTP server, Apache/etc
role :app, "62.76.191.136"                          # This may be the same as your `Web` server
role :db,  "62.76.191.136", :primary => true # This is where Rails migrations will run

set :deploy_to, "/home/vizoria/www/#{application}"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Create shared files and folders"
  task :create_shared do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/tmp"
    run "mkdir -p #{shared_path}/log"
    run "mkdir -p #{shared_path}/system"
    put '', "#{shared_path}/config/database.yml"
  end

  desc "Create links to database.yml, tmp and system"                 
  task :finalize_update do                                            
    run "ln -nfs #{shared_path}/log #{release_path}/log"
    run "ln -nfs #{shared_path}/system #{release_path}/public/system"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/tmp #{release_path}/tmp"
  end

  desc 'Runs rake db:migrate'
  task :apply_migrations, :roles => :db do
    run "cd #{release_path} && RAILS_ENV=production bundle exec rake db:migrate"
  end
  after 'deploy', 'deploy:cleanup'

end

after 'deploy:setup', 'deploy:create_shared'
after 'deploy', 'deploy:apply_migrations'
