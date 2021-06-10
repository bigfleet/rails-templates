# https://guides.rubyonrails.org/v6.0.3/rails_application_templates.html#advanced-usage
def source_paths
  [__dir__]
end

# Set up VSCode dev container
directory "vscode/devcontainer", ".devcontainer"

# Set up gem groups
apply     "gems/basics.rb"

# Configure generators
apply     "snippets/generator_configs.rb"

# Prepare DB config
apply     "databases/postgresql/config.rb"

after_bundle do
  # Basic pages
  
  generate "controller welcome index"
  route "root to: 'welcome#index'"

  # Setup devise
  generate "devise:install"
  generate "devise User"
  generate "devise:views"

  # Setup devise
  generate "rspec:install"

  # Install bootstrap
  apply "snippets/bootstrap.rb"

  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"

  run "cp config/database.yml.devcontainer config/database.yml"
  rake "db:create:all"
end