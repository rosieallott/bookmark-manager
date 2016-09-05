require 'data_mapper'
require 'dm-postgres-adapter'

class Link

  include DataMapper::Resource

    property :id,       Serial
    property :title,    Text
    property :address,  Text

    DataMapper.setup(:default, "postgres://localhost/bookmark_manager_test")
    DataMapper.finalize
    DataMapper.auto_upgrade!

end
