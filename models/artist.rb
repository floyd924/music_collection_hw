require('pg')
require_relative('../db/sql_runner.rb')

class Artist

  attr_reader(:id)
  attr_accessor(:name)

  def initialize(options)
    @id = options['id'].to_i
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


  def self.all()
    sql = "
    SELECT * FROM artists;
    "

    artists_hashes = SqlRunner.run(sql)
    artist_objects = artists_hashes.map do |artist|
      Artist.new(artist)
    end
    return artist_objects
  end

  def albums()
    sql = "
    SELECT * FROM albums
    WHERE artist_id = $1;
    "
    results_hash = SqlRunner.run(sql, [@id])
    results_objects = results_hash.map do |album|
      Album.new(album)
    end
    return results_objects

  end

  def update()
    sql = "
    UPDATE artists
    SET name = $1
    WHERE id = $2;
    "
    values = [@name, @id]

    SqlRunner.run(sql, values)

  end



  def delete()
    #delete all albums by this artist
    sqla = "
    DELETE FROM albums
    WHERE artist_id = $1;
    "
    valuesa = [@id]

    SqlRunner.run(sqla, valuesa)
    #then delete artist

    sqlb = "
    DELETE FROM artists
    WHERE id = $1;
    "
    valuesb = [@id]

    SqlRunner.run(sqlb, valuesb)
  end

  def find()
    sql = "
    SELECT * FROM artists
    WHERE id = $1;
    "

    values = [@id]

    artist_hash = SqlRunner.run(sql, values)
    artist_object = artist_hash.map do |artist|
      Artist.new(artist)
    end
    return artist_object

  end




end
