import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LaundryService extends StatefulWidget {
  const LaundryService({Key? key}) : super(key: key);

  @override
  State<LaundryService> createState() => LaundryService_State();
}

class LaundryService_State extends State<LaundryService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [

        Padding(
          padding: const EdgeInsets.only(top:18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                icon:  Icon(
                  Icons.login_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Container(
            height: 144,
            width: 354,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              color: Colors.blue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                GestureDetector(
                  onTap:(){

          },
                  child: Padding(
                    padding: EdgeInsets.only(top: 28.0),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(
                            "assets/images/wash.png",
                          ),
                          height: 70,
                        ),
                        Center(child: Text("Wash"))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(
                          "assets/images/ironing.png",
                        ),
                        height: 70,
                      ),
                      Center(child: Text("Ironing"))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(
                          "assets/images/dry-cleaning.png",
                        ),
                        height: 70,
                      ),
                      Center(child: Text("DryClean"))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(
                          "assets/images/running-shoes.png",
                        ),
                        height: 70,
                      ),
                      Center(child: Text("Other"))
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
        SizedBox(height: 29,),
        Container(
          decoration: BoxDecoration(  
            borderRadius: BorderRadius.circular(30),
            color: Colors.blue,),
          height: 383,
          width: 354,

        )
        // Column(
        //   children: [
        //     Container(
        //       child: Column(
        //         children: [
        //           Text(
        //             "Dashboard",
        //             style: TextStyle(fontSize: 23),
        //           ),
        //           Row(children: [])
        //         ],
        //       ),
        //     )
        //   ],
        // )
      ]),
    );
  }
}
