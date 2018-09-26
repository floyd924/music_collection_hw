require('pg')
require_relative('../db/sql_runner.rb')

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

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id)
    VALUES ($1, $2, $3)
    RETURNING id;
    "
    values = [@title, @genre, @artist_id]

    results = SqlRunner.run(sql, values)

    @id = results[0]['id'].to_i
  end




end
