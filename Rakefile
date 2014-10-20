require 'rake'
require 'rspec/core/rake_task'
require_relative 'db/config'


desc "create the database"
task "db:create" do
  touch 'db/ar-sunlight-legislators.sqlite3'
end

desc "import data into db"
task "db:import" do
  require_relative 'app'
  file_name = 'db/data/legislators.csv'
  SunlightLegislatorsImporter.import(file_name)
end

desc "update type from title"
task "db:type_to_title" do
  require_relative 'app'
  Politician.all.each do |politician|
    if politician.title == "Rep"
      politician.type = "Representative"
    elsif politician.title == "Sen"
      politician.type = "Senator"
    end
    politician.save
  end
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-sunlight-legislators.sqlite3'
end

desc "loads console with files"
task "db:console" do
  exec "irb -r./app.rb"
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs
