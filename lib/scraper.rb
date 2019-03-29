require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
    def get_page
      html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
      Nokogiri::HTML(html)
    end
    
    def get_courses
      page = get_page
      #courses = []
      page.css(".post")
    end
    
    def make_courses
      courses_page = get_courses
      courses_page.collect do |course_info|
        course = Course.new
        course.title = course_info.css("h2").text
        course.schedule = course_info.css(".date").text
        course.description = course_info.css('p').text
      end
    end
    
    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end



