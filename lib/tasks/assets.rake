# lib/tasks/assets.rake
# The webpack task must run before assets:environment task.
# Otherwise Sprockets cannot find the files that webpack produces.
Rake::Task["assets:precompile"]
  .clear_prerequisites
  .enhance(["assets:compile_environment"])

namespace :assets do
  # In this task, set prerequisites for the assets:precompile task
  task compile_environment: :webpack do
    Rake::Task["assets:environment"].invoke
  end
end