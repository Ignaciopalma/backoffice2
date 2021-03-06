# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'veloexpress'
set :repo_url, 'git@bitbucket.org:felgutier/veloexpress'
set :scm, :git 


set :deploy_via, :copy

set :stages, ["staging", "production"]
set :default_stage, "staging"
set :passenger_restart_with_sudo, true
#set :stage, :production
#set :deploy_to, '/home/veloexpress/apps/veloexpress'

set :linked_files, %w{config/database.yml .env config/secrets.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :keep_releases, 4


namespace :deploy do

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

end
