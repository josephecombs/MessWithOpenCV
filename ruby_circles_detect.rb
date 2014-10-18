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

detect = gray.hough_circles(CV_HOUGH_GRADIENT, 2.0, 10, 200, 10)
puts detect.size
detect.each{|circle|
  puts "#{circle.center.x},#{circle.center.y} - #{circle.radius}"
  result.circle! circle.center, circle.radius, :color => CvColor::Red, :thickness => 3
}

result = result.resize(aaa)

hough_window.show result







#do this at the very end, ultimately
# gray = gray.resize(aaa)
# gray = gray.resize(aaa)
# gray.resize(mp, interpolation = :linear)

# original_window.show image

# original_window.show gray


GUI::wait_key
