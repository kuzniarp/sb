class Song < ActiveRecord::Base
  belongs_to :mediapage
  has_attached_file :clip
  validates_attachment_presence :clip
  validates_attachment_content_type :clip, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ]
  validates_attachment_size :clip, :less_than => 10.megabytes

  before_save :set_song_order

  def set_song_order
    unless self.song_order
      self.song_order = self.mediapage.songs.count
    end
  end
end
