require 'data_mapper'
require 'dm-postgres-adapter'

require_relative 'models/link'
require_relative 'models/tag'

DataMapper.setup( :default,"postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!

 # ENV['DATABASE_URL'] || 
