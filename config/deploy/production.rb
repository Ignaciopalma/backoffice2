set :stage, :production
set :rails_env, :production

server '54.94.253.3', user: 'veloexpress', roles: %w{web app db}, primary: true

