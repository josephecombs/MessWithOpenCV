// build command 
//g++ -o test CircleDetect.cpp -I/opt/local/include -L/opt/local/lib -lopencv_highgui.2.4.10 -lopencv_core.2.4.10 -lopencv_imgproc.2.4.10 -lopencv_imgcodecs.2.4.10 -lopencv_features2d.2.4.10

#include <opencv2/imgcodecs/imgcodecs.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/features2d/features2d.hpp>

#include <iostream>
#include <cstdio>

int main(int argc, char** argv) {
    using namespace cv;

    cv::Mat src=cv::imread("JGRiM.jpg"); 

    if (!src.data) {
        std::cout << "ERROR:\topening image" <<std::endl;
        return -1;
    }
    cv::namedWindow("image",CV_WINDOW_AUTOSIZE);
    cv::imshow("image",src);

    Mat src_gray2;
    cvtColor(src, src_gray2, CV_BGR2GRAY );

    GaussianBlur( src_gray2, src_gray2, cv::Size(9, 9), 2, 2 );

    vector<Vec3f> circles;

    HoughCircles(src_gray2, circles, CV_HOUGH_GRADIENT,
          2,   // accumulator resolution (size of the image / 2)
          5,  // minimum distance between two circles
          100, // Canny high threshold
          100, // minimum number of votes
          0, 1000); // min and max radius

    std::cout << circles.size() <<std::endl;
    std::cout << "end of test" << std::endl;

       std::vector<cv::Vec3f>::
              const_iterator itc= circles.begin();

       while (itc!=circles.end()) {

         cv::circle(src_gray2,
            cv::Point((*itc)[0], (*itc)[1]), // circle centre
            (*itc)[2],       // circle radius
            cv::Scalar(255), // color
            2);              // thickness

         ++itc;
       }
        cv::namedWindow("image",CV_WINDOW_AUTOSIZE);
        cv::imshow("image",src_gray2);
        cv::waitKey(0);
    return 0;
}