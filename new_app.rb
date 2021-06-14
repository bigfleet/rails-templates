# https://guides.rubyonrails.org/v6.0.3/rails_application_templates.html#advanced-usage
def source_paths
  [__dir__]
end

# Git configuration
apply     "snippets/gitignore.rb"

# Set up VSCode dev container
directory "vscode/devcontainer", ".devcontainer"

# Set up gem groups
apply     "gems/basics.rb"

# Configure generators
apply     "snippets/generator_configs.rb"

# Configure testing
apply     "snippets/testing_config.rb"

# Prepare DB config
apply     "databases/postgresql/config.rb"
run       "rm config/database.yml"
template  "databases/postgresql/database.yml.erb", "config/database.yml"
run       "mkdir -p db/skel"
template  "databases/postgresql/skel.create.sql.erb", "db/skel/create.sql"
template  "databases/postgresql/skel.drop.sql.erb", "db/skel/drop.sql"

# DB development rake tasks
copy_file "rake/dbdev.rake", "lib/tasks/dbdev.rake"

after_bundle do
  # Basic pages
  
  generate "controller welcome index"
  route "root to: 'welcome#index'"

  # Setup devise
  generate "devise:install"
  generate "devise User"
  generate "devise:views"

  # Setup rspec
  generate "rspec:install"

  # Install bootstrap
  apply "snippets/bootstrap.rb"
  
  # 'Write' initial tests
  apply "snippets/initial_tests.rb"

  # Apply auth config
  apply  "auth/devise/config.rb"

  # Silly home page
  generate "controller welcome index"

  route "root to: 'welcome#index'"

  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"

end