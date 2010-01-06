class Gallery < Subpage
	has_many :albums, :order => :album_order
end