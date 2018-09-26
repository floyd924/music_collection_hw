require('pg')
require_relative('./db/sql_runner.rb')

class Album

  attr_accessor(:title, :genre)
  attr_reader(:id, :artist_id)

  def initialize(options)
    @id = options['id'].to_i
    @artist_id = options['artist_id'].to_i
    @title = options['title']
    @genre = options['genre']
  end

  def self.delete_all()
    sql = "
    DELETE FROM albums;
    "
    SqlRunner.run(sql)

  end




end
