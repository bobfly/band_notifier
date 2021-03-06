# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'band_notifier'
set :repo_url, 'git@github.com:bobfly/band_notifier.git'
set :user, 'deploy'

set :stage, :production

set :deploy_to, '/home/deploy/band_notifier'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end