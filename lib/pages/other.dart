import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/models/assitantmethods.dart';
import 'package:laundry/utils/constants.dart';
import 'package:laundry/widgets/item_selection.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/Client.dart';

class Other extends StatefulWidget {
  final String title;
  final String image;

  const Other({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  State<Other> createState() => _OtherdescriptionState();
}

class _OtherdescriptionState extends State<Other> {
  TextEditingController requestTitlecontroller = TextEditingController();
  TextEditingController Descriptioncontroller = TextEditingController();
  Map<String, int> itemCountMap = {};

  // List<NearbyArtisans>? availableArtisans;
  String? _currentAddress;
  Position? _currentPosition;

  DatabaseReference? request;
  @override
  void initState() {
    super.initState();
    // final USERNAME= Provider.of<Client>(context).riderInfo?.firstname??"";

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await _getCurrentPosition();
      await AssistantMethod.getCurrentOnlineUserInfo(context);
      // Other initialization code here
    });
  }

  final items = [
    'Problem1',
    'Problem2',
    'Problem3',
    'Problem4',
    'Problem5',
    'Problem6',
    'Problem7'
  ];
  String? value;

  String Address = 'search';

  String? _address, _dateTime;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        print(place.street);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  late int amount;
  late int amount1;
  late int amount2;
  late int amount3;
  late int amount4;

  String? selectedItemImage;
  String? selectedItemTitle;
  String? selectedItemTitle2;
  String? selectedItemTitle3;
  String? selectedItemTitle4;
  String? selectedItemTitle5;
  String? selectedItemCount;
  String? selectedItemCount1;
  String? selectedItemCount2;
  String? selectedItemCount3;
  String? selectedItemCount4;
  String? selectedItemCount5;
  String? selectedItemCount6;

  @override
  Widget build(BuildContext context) {
    final USERNAME = Provider.of<Client>(context).riderInfo?.firstname ?? "";
    // final Helper =Provider.of<helper>(context) ;

    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Constants.whiteback,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      Text('Complete ${widget.title} request',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('State Your Request',
                              style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 18,
                              )),
                          const SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                              elevation: 8,
                              shadowColor: Colors.white70,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  side: BorderSide(
                                      width: 2, color: Colors.white24)),
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                                child: TextField(
                                  controller: requestTitlecontroller,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "",
                                    hintStyle: GoogleFonts.openSans(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Enter Fault Description',
                            style: GoogleFonts.openSans(
                                color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            elevation: 8,
                            shadowColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                side: BorderSide(
                                    width: 2, color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: Descriptioncontroller,
                                maxLines: 6,
                                cursorColor: Colors.black,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: 'Be brief and precise',
                                  hintStyle: GoogleFonts.openSans(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              height: 60.0,
                              width: size.width * .6,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                  ),
                                  onPressed: () {
                                    calculateTotal();
                                    makingRequest();
                                  },
                                  child: Text(
                                    "Complete request",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ]))));
  }

  DropdownMenuItem<String> buildMenueItems(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontSize: 20),
      ));
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  int totalSum = 0;
  void calculateTotal() {
    itemCountMap.forEach((key, value) {
      if (key == 'Shirt') {
        totalSum += amount * value;
      } else if (key == 'T-Shirt') {
        totalSum += amount1 * value;
      } else if (key == 'suit') {
        totalSum += amount2 * value;
      } else if (key == 'Trouser') {
        totalSum += amount3 * value;
      } else if (key == 'Skirt') {
        totalSum += amount4 * value;
      }
    });
    print("Total Sum: $totalSum");
  }

  Future<void> makingRequest() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(15.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 6.0,
                    ),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                    SizedBox(
                      width: 26.0,
                    ),
                    Text("Adding Request, please wait...")
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    try {
      request = FirebaseDatabase.instance
          .ref()
          .child("Request")
          // .child(_firebaseAuth.currentUser!.uid)
          .push();
      final USERNAME =
          Provider.of<Client>(context, listen: false).riderInfo?.firstname ??
              "";
      final phone =
          Provider.of<Client>(context, listen: false).riderInfo?.phone ?? "";

      Map rideInfoMap = {
        "UserName": USERNAME,
        "Phone": phone,
        "created_at": DateTime.now().toString(),
        "Amount": totalSum,
        'selectedItemCount': selectedItemCount,
        'Location': _currentAddress?.trim().toString(),
        'Service Type': widget.title.toString(),
        'finalClient_address': _currentAddress?.trim().toString(),
      };

      await request?.set(rideInfoMap);
      await request?.child("SelectedItem").update({
        "Shirt": selectedItemCount,
        "T-shirt": selectedItemCount1,
        "Suit": selectedItemCount2,
        "Trouser": selectedItemCount3,
        "Skirt": selectedItemCount4,
        "Blouse": selectedItemCount5,
      });

      Navigator.pop(context); // close the progress dialog

      // Show success message
      Fluttertoast.showToast(
        msg: "Request submitted successfully. Thank you!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } catch (error) {
      Navigator.pop(context); // close the progress dialog

      // Show error message
      Fluttertoast.showToast(
        msg: "Error submitting request. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print("Error submitting request: $error");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
}
