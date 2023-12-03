import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
import '../widgets/latest_orders.dart';
import '../widgets/laundryRequest.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Track active index
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Constants.scaffoldBackgroundColor,
//         buttonBackgroundColor: Constants.primaryColor,
//         items: [
//           Icon(
//             Icons.ios_share_rounded,
//             size: 30.0,
//             color: activeIndex == 0 ? Colors.white : Color(0xFFC8C9CB),
//           ),
//           Icon(
//             Icons.map,
//             size: 30.0,
//             color: activeIndex == 1 ? Colors.white : Color(0xFFC8C9CB),
//           ),
//           Icon(
//             Icons.assistant_direction,
//             size: 30.0,
//             color: activeIndex == 2 ? Colors.white : Color(0xFFC8C9CB),
//           ),
//           Icon(
// Icons.heart_broken,            size: 30.0,
//             color: activeIndex == 3 ? Colors.white : Color(0xFFC8C9CB),
//           ),
//           Icon(
//             Icons.settings,
//             size: 30.0,
//             color: activeIndex == 4 ? Colors.white : Color(0xFFC8C9CB),
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             activeIndex = index;
//           });
//         },
//       ),
      backgroundColor: Constants.primaryColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0.0,
            top: -20.0,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                "assets/images/washing_machine_illustration.png",
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: kToolbarHeight,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 36.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Welcome Back,\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "name!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Image.asset(
                            //   "assets/images/dp.png",
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 200.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                        topRight: Radius.circular(60.0),
                      ),
                      color: Constants.scaffoldBackgroundColor,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 24.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                          child: Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Color.fromRGBO(19, 22, 33, 1),
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 7.0),

                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => laundryRequest(),
                                  ),
                                );

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Card(
                                  elevation: 5, // Set elevation for a shadow effect
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0), // Set border radius
                                  ),
                                  color: Colors.white, // Set background color
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(21.0),
                                            child: Image.asset(
                                              "assets/images/wash.png",
                                              scale: 10.0,

                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Wash',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        // Text(
                                        //   'Some additional information goes here.',
                                        //   style: TextStyle(fontSize: 16),
                                        // ),
                                      ],
                                    ),
                                  ),


                                ),
                              ),
                            ),

                            SizedBox(height: 7.0),
//Steam or Iron
                            GestureDetector(
                              onTap: (){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => laundryRequest(),
                                  ),
                                );

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Card(
                                  elevation: 5, // Set elevation for a shadow effect
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0), // Set border radius
                                  ),
                                  color: Constants.whiteback, // Set background color
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(21.0),
                                            child: Image.asset(
                                              "assets/images/ironing.png",
                                              scale: 10.0,

                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Iron',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        // Text(
                                        //   'Some additional information goes here.',
                                        //   style: TextStyle(fontSize: 16),
                                        // ),
                                      ],
                                    ),
                                  ),


                                ),
                              ),
                            )
                          ],
                        )   ,




                        SizedBox(height: 2.0),

                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => laundryRequest(),
                                  ),
                                );

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Card(
                                  elevation: 5, // Set elevation for a shadow effect
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0), // Set border radius
                                  ),
                                  color: Colors.white, // Set background color
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(21.0),
                                            child: Image.asset(
                                              "assets/images/dry-cleaning.png",
                                              scale: 10.0,

                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Dry Clean',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        // Text(
                                        //   'Some additional information goes here.',
                                        //   style: TextStyle(fontSize: 16),
                                        // ),
                                      ],
                                    ),
                                  ),


                                ),
                              ),
                            ),

                            SizedBox(height: 7.0),

                            //others

                            GestureDetector(
                              onTap: (){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => laundryRequest(),
                                  ),
                                );

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Card(
                                  elevation: 5, // Set elevation for a shadow effect
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0), // Set border radius
                                  ),
                                  color: Constants.whiteback, // Set background color
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(21.0),
                                            child: Image.asset(
                                              "assets/images/running-shoes.png",
                                              scale: 10.0,

                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Other',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        // Text(
                                        //   'Some additional information goes here.',
                                        //   style: TextStyle(fontSize: 16),
                                        // ),
                                      ],
                                    ),
                                  ),


                                ),
                              ),
                            )
                          ],
                        )   ,


                        // Container(
                        //   height: ScreenUtil().setHeight(100.0),
                        //   child: Center(
                        //     // lets make a widget for the cards
                        //     child: LocationSlider(),
                        //   ),
                        // ),
                        // LatestOrders(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}