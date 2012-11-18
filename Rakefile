begin
  require 'vlad'
  Vlad.load(app: nil, scm: 'git')
rescue LoadError
  # do nada
end

task :default => 'run_tests'

desc "Run tests"
task :run_tests do
  exec 'rspec'
end

desc "Build Package for Release"
task :package do
  FileUtils.mkdir_p "package/db"
  FileUtils.cp_r "db/.", "package/db"

  FileUtils.mkdir_p "package/model"
  FileUtils.cp_r "model/.", "package/model"

  FileUtils.mkdir_p "package/public"
  FileUtils.cp_r "public/.", "package/public"

  FileUtils.mkdir_p "package/views"
  FileUtils.cp_r "views/.", "package/views"

  FileUtils.cp_r "app.rb", "package/"
  FileUtils.cp_r "Gemfile", "package/"
  FileUtils.cp_r "Gemfile.lock", "package/"

end
