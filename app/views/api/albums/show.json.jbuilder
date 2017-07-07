json.album do
  json.id    @album.id
  json.title @album.title

  json.artist_id @album.artist ? @album.artist.id : nil
end  
