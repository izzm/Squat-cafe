# _your_login_ - Поменять на ваш логин в панели управления
# _your_project_ - Поменять на имя вашего проекта
# _your_server_ - Поменять на имя вашего сервера (Указано на вкладке "FTP и SSH" вашей панели управления)
# set :repository - Установить расположение вашего репозитория
# У вас должна быть настроена авторизация ssh по сертификатам

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

require "bundler/capistrano"
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.2'

your_login = "squat"
your_project = "squat"
your_server = "lithium"

set :application, "RailsShop"
set :scm, :git
set :repository,  "git://github.com/izzm/Squat-cafe.git"

dpath = "/home/hosting_#{your_login}/projects/#{your_project}"

set :user, "hosting_#{your_login}"
set :use_sudo, false
set :deploy_to, dpath

role :web, "#{your_server}.locum.ru" # Your HTTP server, Apache/etc
role :app, "#{your_server}.locum.ru"  # This may be the same as your `Web` server
role :db,  "#{your_server}.locum.ru", :primary => true # This is where Rails migrations will run

after "deploy:update_code", :copy_database_config
after "deploy", "deploy:migrations"

task :copy_database_config, roles => :app do
  db_config = "#{shared_path}/config/database.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
end

set :unicorn_conf, "/etc/unicorn/#{your_project}.#{your_login}.rb"
set :unicorn_pid, "/var/run/unicorn/#{your_project}.#{your_login}.pid"
set :unicorn_rails, "(cd #{deploy_to}/current; rvm use 1.9.2 do bundle exec unicorn_rails -Dc #{unicorn_conf})"

# - for unicorn - #
namespace :deploy do
  desc "Start application"
  task :start, :roles => :app do
    run unicorn_rails
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_rails}"
  end
end
