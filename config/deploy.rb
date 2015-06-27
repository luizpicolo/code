require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :ruby_version, ''

# Repository project
set :repository, ''

# Server Production
task :production do
  set :rails_env, 'production'
  set :user, ''
  set :domain, ''
  set :deploy_to, ''
  set :branch, ''
end

# Server Staging
task :staging do
  set :rails_env, 'staging'
  set :user, ''
  set :domain, ''
  set :deploy_to, ''
  set :branch, ''
end

# Server development
task :development do
  set :rails_env, 'development'
  set :user, ''
  set :domain, ''
  set :deploy_to, ''
  set :branch, ''
end

# Fix
set :term_mode, nil

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log', 'tmp', 'config/application.yml', 'config/secrets.yml']

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :"rvm:use[ruby-#{ruby_version}@#{user}]"
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/storage"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/storage"]

  queue! %[touch "#{deploy_to}/storage/index.html"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[mkdir -p "#{deploy_to}/shared/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/pids"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/application.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/application.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/secrets.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/secrets.yml'."]
end

# Show logs
desc "Show logs rails."
task :'logs:rails' => :environment do
  queue 'echo "Contents of the log file are as follows:"'
  queue "tail -f #{deploy_to}/shared/log/production.log"
end

desc "Show logs Nginx."
task :'logs:nginx' => :environment do
  queue 'echo "Contents of the log file are as follows:"'
  queue "tail -f /opt/nginx/logs/error.log"
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      queue %[echo -n "-----> Creating new restart.txt: "]
      queue "touch #{deploy_to}/shared/tmp/restart.txt"
    end
  end
end

# Roolback
desc "Rolls back the latest release"
task :rollback => :environment do
  queue! %[echo "-----> Rolling back to previous release for instance: #{domain}"]

  # Delete existing sym link and create a new symlink pointing to the previous release
  queue %[echo -n "-----> Creating new symlink from the previous release: "]
  queue %[ls "#{deploy_to}/releases" -Art | sort | tail -n 2 | head -n 1]
  queue! %[ls -Art "#{deploy_to}/releases" | sort | tail -n 2 | head -n 1 | xargs -I active ln -nfs "#{deploy_to}/releases/active" "#{deploy_to}/current"]

  # Remove latest release folder (active release)
  queue %[echo -n "-----> Deleting active release: "]
  queue %[ls "#{deploy_to}/releases" -Art | sort | tail -n 1]
  queue! %[ls "#{deploy_to}/releases" -Art | sort | tail -n 1 | xargs -I active rm -rf "#{deploy_to}/releases/active"]

  queue %[echo -n "-----> Creating new restart.txt: "]
  queue "touch #{deploy_to}/shared/tmp/restart.txt"
end

# Maintenance
# TornOff (Necessary gem https://github.com/biola/turnout)
desc "TurnOff"
task :'system:turnoff' => :environment do
  queue %[echo -n "-----> Turn Off System: "]
  queue! %[cd "#{deploy_to}/current"]
  queue "RAILS_ENV=#{rails_env} bundle exec rake maintenance:start"
end

desc "TurnOn"
task :'system:turnon' => :environment do
  queue %[echo -n "-----> Turn Off System: "]
  queue! %[cd "#{deploy_to}/current"]
  queue "RAILS_ENV=#{rails_env} bundle exec rake maintenance:end"
end

# Server
# Need sudo user
# Restart Nginx
desc "Restart Server"
task :'server:restart' => :environment do
  queue %[echo -n "-----> Restart nginx Service: "]
  queue 'sudo service nginx restart'
end

# Start Nginx
desc "Start Server"
task :'server:start' => :environment do
  queue %[echo -n "-----> Start nginx Service: "]
  queue 'sudo service nginx start'
end

# Stop Nginx
desc "Stop Server"
task :'server:stop' => :environment do
  queue %[echo -n "-----> Stop nginx Service: "]
  queue 'sudo service nginx stop'
end

# Migration Seed
desc "Seed"
task :'db:seed' => :environment do
  queue %[echo -n "-----> Seed: "]
  queue! %[cd "#{deploy_to}/current"]
  queue "RAILS_ENV=#{rails_env} bundle exec rake db:seed"
end

desc "Create DB"
task :'db:create' => :environment do
  queue %[echo -n "-----> Seed: "]
  queue! %[cd "#{deploy_to}/current"]
  queue "RAILS_ENV=#{rails_env} bundle exec rake db:create"
end

desc "Reset DB"
task :'db:reset' => :environment do
  queue %[echo -n "-----> Seed: "]
  queue! %[cd "#{deploy_to}/current"]
  queue "RAILS_ENV=#{rails_env} bundle exec rake db:migrate:reset"
end
