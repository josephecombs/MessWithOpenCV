#!/usr/bin/env ruby
# houghcircle.rb
require "rubygems"
require "opencv"
include OpenCV

#gross window resizing code
class MySize
  def width
    1200
  end
  def height
    800
  end
end

mp = MySize.new
CvSize.compatible?(mp)  #=> true
aaa = CvSize.new(mp)          #=> same as CvSize(10, 20)

original_window = GUI::Window.new("original", flags = CV_WINDOW_NORMAL)
hough_window = GUI::Window.new "hough circles"

image = IplImage::load "test2.jpg"
gray = image.BGR2GRAY
# gray = gray.resize(1200,800)
gray = gray.canny(1100, 40)
# hough_window.show gray

# sleep 100
#
# detect = gray.hough_circles(CV_HOUGH_GRADIENT, 1, 20, 50, 30, 100)
puts gray.rows


# detect.each{|circle|
#   puts "#{circle.center.x},#{circle.center.y} - #{circle.radius}"
#   gray.circle! circle.center, circle.radius, :color => CvColor::Red, :thickness => 3
# }

gray.circle!(CvPoint.new(gray.width / 2, gray.height / 2), 800,
               :color => CvColor::Blue, :thickness => 1, :line_type => :aa)

# result = result.resize(aaa)
gray = gray.resize(aaa)

gray.circle! OpenCV::CvPoint.new(500,500), 500, color: CvColor::Red, thickness: 3

hough_window.show gray
# hough_window.show gray






#do this at the very end, ultimately
# gray = gray.resize(aaa)
# gray = gray.resize(aaa)
# gray.resize(mp, interpolation = :linear)

# original_window.show image

# original_window.show gray


GUI::wait_key
