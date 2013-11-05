require 'nokogiri'

doc = Nokogiri::HTML(open(File.expand_path('../../../sample.xml', __FILE__)))
contacts = doc.xpath("//title")