require('pg')
require_relative('./db/sql_runner.rb')

class Artist

  attr_reader(:id)
  attr_accessor(:name)

  def initialize(options)
    @id = options['id']
    @name = options['name']
  end

  def self.delete_all()
    sql = "
    DELETE FROM artists;
    "
    SqlRunner.run(sql)

  end

end
