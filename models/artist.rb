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




end
