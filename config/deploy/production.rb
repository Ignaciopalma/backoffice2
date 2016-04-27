set :stage, :production
set :rails_env, :production
set :deploy_to, '/home/veloexpress/apps/veloexpress'
set :branch, 'master'

server '54.94.253.3', user: 'ubuntu', roles: %w{web app db}, primary: true
