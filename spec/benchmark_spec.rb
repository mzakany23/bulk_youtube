require_relative '../lib/bulk_youtube/benchmark_testing'

describe "Benchmark" do 

	before do 
		path = 'https://www.youtube.com/watch?v=z5pJvhd3lFQ'
		save = '/Users/mzakany/Desktop/folder'
		@found = BenchmarkTest.new(path,save, 10)					
	end

	it 'should' do 
		@found.grab_links.show
			

	end

end