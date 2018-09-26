require('pg')
require_relative('../db/sql_runner.rb')

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


  def save()
    sql = "
    INSERT INTO artists (name)
    VALUES ($1)
    RETURNING id;
    "
    values = [@name]

    results = SqlRunner.run(sql, values)

    @id = results[0]['id'].to_i

  end

end
