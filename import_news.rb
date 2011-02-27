require 'rubygems'
require 'nokogiri'
require 'rmagick'
require 'dm-core'
require 'dm-mysql-adapter'
require './post.rb'

require './config.rb'

def icrop(img_name)
  img_name = img_name.gsub!(" ", "\ ")
  puts "proccessing: #{img_name}"
   img = Magick::Image.read("#{IMAGES_SOURCE_PATH}#{img_name}").first
   n_img = img.crop(0, 0, IMAGES_WIDTH, IMAGES_HEIGHT)
   n_img.write("#{IMAGES_DESTINATION_LOCAL}#{IMAGES_DESTINATION_PATH}#{img_name.gsub!(" ", "_")}")
end



doc = Nokogiri::XML(File.new(XML_FILE))

entry = nil
doc.xpath("//ContentItem").each do |news_item|
  #puts "+"*80
  news_item.traverse do |item|
      if (item.name == "body.head") 
        #puts "Title: \n#{item.content.strip}"
        entry = Post.new if entry.nil?
        entry.title = item.content.strip
      end
      if (item.name == "body.content") 
        #puts "Title: \n#{item.inner_html.strip}"
        entry = Post.new if entry.nil?
        entry.body = item.inner_html.strip
      end
      if (item.name == "ContentItem" && !item.attr('Href').nil?)
        #puts "Image: \n#{item.attr('Href').strip}"
        icrop(item.attr('Href'))
        #entry.image =item.attr('Href')
        entry.complete()
        entry.save
        puts "SAVED: #{entry.id}"
        image = Post.new
        image.create_image(entry, item.attr('Href').strip)
        image.save
        entry = nil
      end
  end
end

