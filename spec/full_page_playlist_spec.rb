require 'spec_helper'


describe 'Full Page Playlist' do 
	before do 
		@EEVlog = 'https://www.youtube.com/playlist?list=PL55857F4F6F2D36B1'
		@french = 'https://www.youtube.com/playlist?list=PLV1-QgpUU7N2TVWS6gEVMqEfAFjAl-DV6'
		@save_to = '/Users/mzakany/Desktop/folder'
		
		@found = BulkYoutube::Scrape.new(@EEVlog, @save_to)
		@found_french = BulkYoutube::Scrape.new(@french, @save_to)
	end

	context 'Grab Links with no parameters' do 
		it 'should get eevlog links' do 
			# @found.grab_links.class
			# expect(@found_french.grab_links).to be_an_instance_of Array
		end
	end

	context 'Grab with word search' do 
		it 'should get with word search ' do 
			# expect(@found.grab_links('EEVblog')).to be_an_instance_of Array
			# @found_french.grab_links('French').show
		end
	end

	context 'Send to folder' do 

		before do 
			@run_french = BulkYoutube::Scrape.new(@french, @save_to)
		end

		it 'should do no parameters' do 
			@run_french.grab_links('French').you_convert
		end

	end
end

