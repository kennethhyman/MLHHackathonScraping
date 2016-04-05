require 'httparty'
require 'nokogiri'

class Hackathon
	def initialize html
		@name = search_html(html, "h3").text


		@logo = search_html(html, 'img')[0]['src']


		@location = search_html(html, "p")[1].text


		@date = search_html(html, "p")[0].text


		@site = search_html(html, "a")[0]['href']


		@highschool = false
		
		unless (search_html(html, ".ribbon-wrapper").text == "")
			@highschool = true
		end

		if @highschool
			puts @name + " is a highschool hackathon"
		end
	end

	def to_s
		@name + "\t" + @date + "\t" + @location + "\t" + @site
	end

	private
	def search_html html, details

		html.css(details)
	end
end


hackathon_page = Nokogiri::HTML(HTTParty.get("https://mlh.io/seasons/s2016/events"))
page_divs = hackathon_page.css('div')
hackathon_divs = page_divs[7]

hackathon_html = hackathon_divs.css('div.event')

hackathons = Array.new

hackathon_html.each do |event|
	hackathons << Hackathon.new(event)
end