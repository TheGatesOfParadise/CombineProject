# CombineProject

This project demonstrates how to use basic combine and Latest/Zip operator to retreive data and then present it to a view

`Use Combine Latest operator`
Video: https://www.youtube.com/watch?v=UvXvFa-k6dw&list=PLSbpzz0GJp5QHQPK3QPjzuwoRn62zDtL8&index=2
ViewController -- shows a signup page, it has user name, password and t&n switch and signup button.

Inside ViewController, it uses latest operator to disable signup button until username, password and t&n are filled 

`Basic Combine to read json from file system`
Video: https://www.youtube.com/watch?v=2ORJcQgP4a0&list=PLSbpzz0GJp5QHQPK3QPjzuwoRn62zDtL8&index=1
FlightOverviewView2 - shows a list of flight information

It uses HomeViewModel to retrive a json file and decode it to a list of Flight 

The code from the video is actually called Whoosh.  The original code reads from a web service to get a string file

`Use Combine Zip operator`
https://www.youtube.com/watch?v=3XhSFiXtYxw&list=PLSbpzz0GJp5QHQPK3QPjzuwoRn62zDtL8&index=3
FlightOverView1  - same look and feel as FlightOverviewView2

It uses ZipOperator's SignUpViewModel.  The VM uses 2 publishers and zip them together to form a userProfile object.  Then the view read from userProfile

FlightCardView is copied from Whoosh, no change.

FlightDetailView is not used in this project, see Whoosh for its implementation

=============================================
Lessons learned
=============================================

1. In each flight overview screen,  viewModel.flights or viewModel.userProfile.flights should not be nil.   At the begining they should be empty, so the view display an empty screen, because of the @Published property inside ViewModel,  the view will be automatically updated when the property is retrieved successfully
