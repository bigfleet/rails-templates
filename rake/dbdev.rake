# In this namespace, we are free to assume we are in the VSCode devcontainer composition.
# That means we have a 'db' host with postgres basics. [jvf]

namespace :dbdev do
  task :up do
    sh "PGPASSWORD=postgres psql -U postgres -h db -f db/skel/create.sql"
  end

  task :down do
    sh "PGPASSWORD=postgres psql -U postgres -h db -f db/skel/drop.sql"
  end

  task dbr: ["dbdev:down", "dbdev:up", "db:migrate", "db:test:prepare"] do
  end
end