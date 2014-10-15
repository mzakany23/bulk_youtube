# this file tests many different types of youtube urls and playlists
require 'spec_helper'

describe 'Playlist' do 
	before do 
		@temples = 'https://www.youtube.com/watch?v=mLPvEfB8F2I&list=UU3I2GFN_F8WudD_2jUZbojA'
		@of_monsters = 'https://www.youtube.com/watch?v=8Dw8qdmT_aY&list=TLF8Mb1J2-C51c-0bwT31CLxHjPDNIDemE'
		@shovels_rope = 'https://www.youtube.com/watch?v=SFzWiUeooEY&list=PLB88CA03885F74F2B'
		@save_to = '/Users/mzakany/Desktop/folder'
	end

	context 'Grab the links with no parameters' do 
		
		it 'should get temples' do
			# theres a ton of links so I commented out 
			found_links = BulkYoutube::Scrape.new(@temples, @save_to)
			# found_links.grab_links.count				
		end

		it 'should get of_monsters' do 
			found_links = BulkYoutube::Scrape.new(@of_monsters,@save_to)
			# found_links.grab_links.count
		end
	end

	context 'Grab the links with word search' do 
		it 'should get Monsters' do 
			found_links = BulkYoutube::Scrape.new(@of_monsters,@save_to)
			# found_links.grab_links('Monsters').show
		end
	end

	context 'Send files to folder' do 
		before do 
			@run = BulkYoutube::Scrape.new(@of_monsters, @save_to)
		end

		it 'should send no parameter to folder' do 
			# links = @run.grab_links.links
			# @run.you_convert(links)
		end

		it 'should send with word search to folder' do 
			# links = @run.grab_links('Monsters')
			# @run.you_convert(links)
		end
	end
	
	
end