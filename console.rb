require_relative('./models/artist.rb')
require_relative('./models/album.rb')
require('pry')

Album.delete_all
Artist.delete_all

artist1 = Artist.new({
  'name' => 'Green Day'
})

artist2 = Artist.new({
  'name' => 'Neck Deep'
})

album1 = Album.new({
  'title' => 'Life''s Not Out To Get You',
  'genre' => 'Pop-Punk',
  'artist_id' => artist2.id
})

album2 = Album.new({
  'title' => 'American Idiot',
  'genre' => 'Alternative & Punk',
  'artist_id' => artist1.id
  })

  artist1.save()
  artist2.save()

  album1.save()
  album2.save()