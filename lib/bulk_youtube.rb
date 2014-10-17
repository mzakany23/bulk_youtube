require "bulk_youtube/version"
require "bulk_youtube/globals"
require 'mechanize'
require 'nokogiri'
require 'benchmark'


module BulkYoutube
  class Scrape
		include Globals

		attr_accessor :search_path, :save_destination, :max_retries

		def initialize(search_path=nil, save_destination=nil, max_downloads=2, max_retries=10)
			@search_path = search_path
			@save_destination = save_destination
			@max_downloads = max_downloads
			@max_retries = max_retries
		end
		

		def you_convert
			begin
				send_files(@link_arr)
			rescue StandardError
				false
				retry
			end
		end

		def grab_links(word=nil)	
			gather(word)
		end

		def show
			arr = []
			@link_arr.each do |link|
				REPLACE.each do |r|
					link.text.gsub!(r[0], r[1])
				end
				arr << link
			end
			arr
		end

		def links
			@link_arr
		end






	private

	def noko(path)
		Nokogiri::HTML(path)
	end

	def mec_get(path)
		Mechanize.new.get(path)	
	end

	# returns itself
	def gather(word)
		@link_arr = []
		path = mec_get(@search_path)
		count = 0

		if word.nil?
		
			path.links_with(:href => /watch\?v=/).each do |link|				
				break if count > @max_downloads
					@link_arr << link
					count += 1
				end

			else

				path.links_with(:text => /#{word}/).each do |link|
					break if count > @max_downloads		
						if link.text.include?(word) && link.href.include?('watch?v=')
							@link_arr << link
							count += 1
						end
				end
			end
			self
	end

	# requires an array
	def send_files(links)
		you_convert = 'http://www.youtubeinmp4.com/'
		links.each_with_index do |link, i|	
			clicked_link = link.href
			form = mec_get(you_convert).forms[0]
			next if link.nil?
			puts "printing link #{i}"
			form.field_with(:class => 'c3').value = clicked_link
			path = "#{@save_destination}/#{i}.mp4"
			form.submit.links[1].click.save_as(path)
			puts "link #{1} successful"
		end
	end
	end
end
