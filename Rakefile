require 'data_mapper'
require './app/app.rb'

task :dm_upgrade do
  DataMapper.auto_upgrade!
  puts "Auto-upgrade complete (no data loss)"
end

task :dm_migrate do
  DataMapper.auto_migrate!
  puts "Auto-migrate complete (data was lost)"
end
