#!/usr/bin/env ruby

require 'nokogiri'

def sh cmd
  puts cmd
  system(cmd)
end

sh('landslide -t theme --embed slide.md')
slide = Nokogiri::HTML.parse(File.read('presentation.html'))
sh('rm presentation.html')

# strip full path
slide.css('.source a').each{ |n| n['href'] = n.inner_text }

# strip title
title = slide.css('title').first
title.content = title.children.reject{ |e|
                  e.element? && e.children.empty? }.join("\u{2014}")

# fix line number and remove some space
slide.css('.lineno').each{ |n|
  n.inner_html = '%02d' % n.inner_text.strip.to_i
  n.next.replace n.next.inner_text.sub('   ', ' ') # one space is enough
}

File.open('../../2011-08-27-rest-core.html', 'w'){ |f| f.puts slide.to_html }
puts("Created #{File.expand_path('../../2011-08-27-rest-core.html')}")
