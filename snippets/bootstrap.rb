def yarn(*packages)
  run("yarn add #{packages.join(" ")}")
end

yarn 'bootstrap@5.0.1'

remove_file "app/views/layouts/application.html.erb"

empty_directory "app/views/application"
copy_file "frontend/application.html.erb", "app/views/layouts/application.html.erb"
copy_file "frontend/flashes.html.erb", "app/views/application/_flashes.html.erb"
copy_file "frontend/javascript.html.erb", "app/views/application/_javascript.html.erb"
copy_file "frontend/flashes_helper.rb", "app/helpers/flashes_helper.rb"
