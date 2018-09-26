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

  def update()
    sql = "
    UPDATE albums
    SET (title, genre, artist_id) = ($1, $2, $3)
    WHERE id = $4;
    "
    values = [@title, @genre, @artist_id, @id]

    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "
    DELETE FROM albums
    WHERE id = $1;
    "
    values = [@id]

    SqlRunner.run(sql, values)
  end

  def find()
    sql = "
    SELECT * FROM albums
    WHERE id = $1;
    "

    values = [@id]

    album_hash = SqlRunner.run(sql, values)
    album_object = album_hash.map do |alb|
      Album.new(alb)
    end
    return album_object

  end







end
