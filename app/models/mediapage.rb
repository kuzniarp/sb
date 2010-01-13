class Mediapage < Subpage
  has_many :songs, :order => :song_order
end
