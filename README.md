# Youtube Bulk Video Downloader:
=======
```
Uses mechanize (2.7.2) and nokogiri (1.6.1)

Purpose: when you need to download multiple youtube files, say a course or tutorial i.e. to watch offline. 

Note: change the @max_downloads to increase the amount of mp4s can send.

```


Variables:
==========

```
> search = 'https://www.youtube.com/playlist?list=PLV1-QgpUU7N2TVWS6gEVMqEfAFjAl-DV6'
> save = '/path/to/save'
> word = 'French'
```

Send mp4's to your local folder:
==========


```
Without keyword search:
> find = Scrape.new(search,save)
> find.grab_links.links #show the link objects as is
> find.grab_links.show #show a more concise version  
> find.you_convert #send links to folder
```
```
With keyword search:
> find = Scrape.new(search,save)
> find.grab_links('French').links
> find.grab_links('French').you_convert
```
```
Set to download more
> Scrape.new(search,save,10).grab_links.you_convert
```