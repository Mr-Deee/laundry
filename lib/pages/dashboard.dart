import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/models/Client.dart';
import 'package:laundry/widgets/laundry_selection.dart';
import 'package:provider/provider.dart';

import '../models/assitantmethods.dart';
import '../utils/constants.dart';
import '../widgets/latest_orders.dart';
// import '../widgets/laundryRequest.dart';
import '../widgets/order_description.dart';
import 'other.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await AssistantMethod.getCurrentOnlineUserInfo(context);
      // Other initialization code here
    });
  }

  // Track active index
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final name = Provider.of<Client>(context).riderInfo?.firstname ?? "Loading";
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Constants.scaffoldBackgroundColor,
        buttonBackgroundColor: Constants.primaryColor,
        items: [
          Icon(
            Icons.home,
            size: 30.0,
            color: activeIndex == 0 ? Colors.white : Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.schedule,
            size: 30.0,
            color: activeIndex == 1 ? Colors.white : Color(0xFFC8C9CB),
          ),
          // Icon(
          //   Icons.assistant_direction,
          //   size: 30.0,
          //   color: activeIndex == 2 ? Colors.white : Color(0xFFC8C9CB),
          // ),
          // Icon(
          //     Icons.heart_broken,            size: 30.0,
          //   color: activeIndex == 3 ? Colors.white : Color(0xFFC8C9CB),
          // ),
          Icon(
            Icons.settings,
            size: 30.0,
            color: activeIndex == 2 ? Colors.white : Color(0xFFC8C9CB),
          ),
        ],
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
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
                                    text: name!,
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

                            IconButton(
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Sign Out'),
                                      backgroundColor: Colors.white,
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                                'Are you certain you want to Sign Out?'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            'Yes',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            print('yes');
                                            FirebaseAuth.instance.signOut();
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                "/login",
                                                (route) => false);
                                            // Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                            ),
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
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(19, 22, 33, 1),
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 7.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Wash
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const Problem_description(
                                            image: 'assets/images/wash.png',
                                            title: 'Wash',
                                          )));
                                },
                                child: laundry_selection(
                                  image: 'assets/images/wash.png',
                                  title: 'Wash',
                                ),
                              ),
                            ),

                            SizedBox(height: 7.0),
//Steam or Iron
                            //Wash
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const Problem_description(
                                            image: 'assets/images/ironing.png',
                                            title: 'Iron',
                                          )));
                                },
                                child: laundry_selection(
                                  image: 'assets/images/ironing.png',
                                  title: 'Iron',
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 2.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Dry Clean
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const Problem_description(
                                            image:
                                                'assets/images/dry-cleaning.png',
                                            title: 'Dry Clean',
                                          )));
                                },
                                child: laundry_selection(
                                  image: 'assets/images/dry-cleaning.png',
                                  title: 'Dry Clean',
                                ),
                              ),
                            ),
                            SizedBox(height: 7.0),

                            //others
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const Other(
                                            image:
                                                'assets/images/running-shoes.png',
                                            title: 'Others',
                                          )));
                                },
                                child: laundry_selection(
                                  image: 'assets/images/running-shoes.png',
                                  title: 'Others',
                                ),
                              ),
                            ),
                          ],
                        ),

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
