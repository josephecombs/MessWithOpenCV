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
# image = IplImage::load "test4.jpg"
gray = image.BGR2GRAY

#eprhaps smooth the image prior to performing edge detection?
# gray = gray.smooth(CV_GAUSSIAN,5,5)
# gray = gray.smooth(CV_BLUR,5,5)
gray = gray.canny(1100, 200)
hough_window.show gray

#
#pass through once...
#the original image is probably too detailed so we need to filter it a bit to get our circles
gray = gray.smooth(CV_GAUSSIAN,5,5)
# gray = gray.smooth(CV_BLUR,17,17)


# see here http://stackoverflow.com/questions/23976766/hough-circle-detection-accuracy-very-low
# method - CV_HOUGH_GRADIENT
# minDist - 100
# dp - 1
# param1 - 80
# param2 - 10
# minRadius - 250
# maxRadius - 300
# usage:
# hough_circles(method, dp, min_dist, param1, param2, min_radius = 0, max_radius = 0)
detect = gray.hough_circles(CV_HOUGH_GRADIENT, 1, 100, 80, 10)
# detect = gray.hough_circles(CV_HOUGH_GRADIENT, 2, 160, 50, 30)
puts gray.rows


detect.each{|circle|
   puts "#{circle.center.x},#{circle.center.y} - #{circle.radius}"
   image.circle! circle.center, circle.radius, :color => CvColor::Red, :thickness => 3
}

# gray.circle!(CvPoint.new(gray.width / 2, gray.height / 2), 800, :color => CvColor::Blue, :thickness => 1, :line_type => :aa)

# result = result.resize(aaa)
gray = gray.resize(aaa)



hough_window.show gray
# hough_window.show gray
# image = image.smooth(CV_BLUR,10,10)
image = image.resize(aaa)
original_window.show image






#do this at the very end, ultimately
# gray = gray.resize(aaa)
# gray = gray.resize(aaa)
# gray.resize(mp, interpolation = :linear)

# original_window.show image

# original_window.show gray


GUI::wait_key
