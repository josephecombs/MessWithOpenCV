// build command g++ -o test main.cpp -I/opt/local/include -L/opt/local/lib -lopencv_highgui.2.4.10 -lopencv_core.2.4.10 -lopencv_imgproc.2.4.10

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <iostream>

int main(){
	
    cv::Mat image = cv::imread("/Users/jcombs/Desktop/MessWithOpenCV/FullSizeRender.jpg");
	// std::cout << image;
    cv::Mat contours;
    cv::Mat gray_image;

	std::vector<cv::Mat> channels;
	cv::Mat hsv;
	cv::cvtColor( image, hsv, CV_RGB2HSV );
	cv::split(hsv, channels);
	gray_image = channels[0];

    cv::Canny(image,contours,30,350);

    cv::namedWindow("Image");
    cv::imshow("Image",image);

    cv::namedWindow("Gray");
    cv::imshow("Gray",gray_image);

    cv::namedWindow("Canny");
    cv::imshow("Canny",contours);
    cv::waitKey(0);
}