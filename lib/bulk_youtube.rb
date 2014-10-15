require "bulk_youtube/version"
require "bulk_youtube/globals"
require 'mechanize'
require 'nokogiri'

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
			retry_count = 0
			begin
				send_files(@link_arr)
			rescue Net::HTTP::Persistent::Error => e
				raise unless e.message =~ /too man connection resets/
				if retry_count > @max_retries
					 puts "**** WARN: Mechanize retried connection reset #{@max_retries} times"
					 raise
				end
				retry_count +=1 
				Mechanize::HTTP::Agent.http.shutdown
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
		
			path.links.each do |link|
				break if count > @max_downloads
					youtube = link.click.uri.to_s
					
					next if link.text.include?('Play')

					if youtube.include?('watch?v=')
						@link_arr << link
						count += 1
					end
				end

			else

				path.links.each do |link|

					break if count > @max_downloads
					
					# next if link.text.include?('Play')
					
					if link.text.include?(word) && link.click.uri.to_s.include?('watch?v=')
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
			clicked_link = link.click.uri.to_s
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
