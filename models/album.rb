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

  def self.all()
    sql = "
    SELECT * FROM albums;
    "
    albums_hashes = SqlRunner.run(sql)

    albums_objects = albums_hashes.map do |album|
      Album.new(album)
    end

    return albums_objects

  end


  def artist()
    sql = "
    SELECT * FROM artists
    WHERE id = $1
    "
    results = SqlRunner.run(sql, [@artist_id])

    artist = Artist.new(results[0])

    return artist
    
  end




end
