# +++++++++++++++++++++++++++++++++++++++++++
# Modified from nomad-labs cap deploy file
#++++++++++++++++++++++++++++++++++++++++++++

set :application,	'farmers_census'
set :user,		'justink'
set :domain,		'74.63.13.21'
set :mongrel_port,	'4266'
set :server_hostname,	'www.serveyourcountryfood.net'



# Make your choice of source code management here, dependent on which your 
# application is currently stored in
#
# comment out if it gives you trouble. newest net/ssh needs this set.
ssh_options[:paranoid] = false

# ==============================================================================
# DEPLOYING USING GITHUB
# ==============================================================================

set :scm, :git
set :github_user, "cupricoxide"
set :github_app, "farmers_census"
# # Replace this with your git repository name
set :repository,  "git@github.com:#{github_user}/#{github_app}.git"
# # Replace this with your git username
set :scm_user,    github_user
set :runner,	  github_user
set :use_sudo,	  false
set :scm_passphrase, "farmers#1024"

set :user,	"justink"
role :app, server_hostname  ## serveyourcountryfood.net
role :web, server_hostname
role :db,  server_hostname, :primary => true

# # This is the branch you wish to deploy, by default we've set it to master,
# # however you might want to set it to 'stable' or some other branch you're using
set :branch,		"master"
set :deploy_via,	:remote_cache
set :git_shallow_clone,	1
set :git_enable_submodules, 1
set :sql_pass,         'mind1024'
set :application,      'farmers_census'
set :deploy_to,        "/home/#{user}/apps/#{application}"

# # Deploy using an ssh agent.  On Mac OS X you may need to run:
# # or something similar, to add your key to the agent and run it
# #  ssh-agent; ssh-add ~/.ssh/id_dsa
#
set :ssh_options, { :forward_agent => true }



default_run_options[:pty] = true

# =============================================================================
# Any custom after tasks can go here.
# after "deploy:symlink_configs", "express_custom"
# task :express_custom, :roles => :app, :except => {:no_release => true, :no_symlink => true} do
#   run <<-CMD
#   CMD
# end
# =============================================================================

namespace(:mongrel) do
  task :restart, :roles => :app do
    run "sudo monit restart all -g rails"
  end
  
  task :start, :roles => :app do
    run "sudo monit start all -g rails"
  end
  
  task :stop, :roles => :app do
    run "sudo monit stop all -g rails"
  end
  
  task :kill, :roles => :app, :on_error => :continue do
    run "sudo pkill -9 mongrel_rails"
  end
end

namespace(:deploy) do  
  task :symlink_configs, :roles => :app, :except => { :no_symlink => true } do
    run  "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run  "ln -nfs #{shared_path}/config/environment.rb #{release_path}/config/environment.rb"
    run  "ln -nfs #{shared_path}/deployed_apps/farmers_census/public/avatars #{release_path}/public"
  end

  desc "Long deploy will throw up the maintenance.html page and run migrations 
        then it restarts and enables the site again."
  task :long do
    transaction do
      update_code
      web.disable
      symlink
      migrate
    end
  
    restart
    web.enable
  end

  desc "Restart the Mongrel processes on the app server by calling restart_mongrel_cluster."
  task :restart, :roles => :app do
    mongrel.restart
  end

  desc "Start the Mongrel processes on the app server by calling start_mongrel_cluster."
  task :spinner, :roles => :app do
    mongrel.start
  end
end

namespace(:db) do
  task :migrate, :roles => :app, :except => { :no_symlink => true } do
    run "rails_ENV=#{rails_env} rake db:migrate"
  end
end


# TASKS
# Don't change unless you know what you are doing!
after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"
after "deploy:update_code","deploy:symlink_configs"
# uncomment the following to have a database backup done before every migration
# before "deploy:migrate", "db:dump"
