require 'iconv'
class UnicodeNormalizer
  def self.normalize(text)
  #Unicode.normalize(text.strip).gsub(/[^\x00-\x7F]/n,'')
	#text.gsub(/[^\x00-\x7F]/n,'').gsub(/\s/,'_').downcase
	text.to_s.to_ascii.gsub(/\s/,'_').downcase
  end
  
end
class String
	def to_ascii
		ascii = "acelnoszzACELNOSZZ"
    cep = "\271\346\352\263\361\363\234\277\237\245\306\312\243\321\323\214\257\217"
		s = Iconv.new("cp1250", "UTF-8").iconv(self)
		s.tr(cep,ascii)
	end
end
