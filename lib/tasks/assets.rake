# lib/tasks/assets.rake
# The webpack task must run before assets:environment task.
# Otherwise Sprockets cannot find the files that webpack produces.
Rake::Task["assets:precompile"]
  .clear_prerequisites
  .enhance(["assets:compile_environment"])
