import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/utils/constants.dart';
import 'package:laundry/widgets/item_selection.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/Client.dart';

class Problem_description extends StatefulWidget {
  final String title;
  final String image;

  const Problem_description(
      {Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  State<Problem_description> createState() => _Problem_descriptionState();
}

class _Problem_descriptionState extends State<Problem_description> {
  TextEditingController requestTitlecontroller = TextEditingController();
  TextEditingController Descriptioncontroller = TextEditingController();

  // List<NearbyArtisans>? availableArtisans;
  String? _currentAddress;
  Position? _currentPosition;

  DatabaseReference? request;

  @override
  void initState() {
    _getCurrentPosition();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<helper>(context, listen: false).getCurrentLocation();
    //   Provider.of<helper>(context, listen: false).getAddressFromLatLng();
    //
    //
    // });
    super.initState();
    //  print("Current : $_currentAddress");
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

  @override
  Widget build(BuildContext context) {
    // Provider.of<helper>(context).getCurrentLocation();
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              item_selection(
                                image: 'assets/images/shirt.png',
                                title: 'Shirt',
                              ),



                              item_selection(
                                image: 'assets/images/tshirt.png',
                                title: 'T-Shirt',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              item_selection(
                                image: 'assets/images/suit.png',
                                  title: 'suit',
                              ),



                              item_selection(
                                image: 'assets/images/trousers.png',
                                title: 'Trouser',
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              item_selection(
                                image: 'assets/images/skirt.png',
                                title: 'Skirt',
                              ),



                              item_selection(
                                image: 'assets/images/blouse.png',
                                title: 'Blouse',
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          Text('Location',
                              style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 18,
                              )),

                          //location

                          Card(
                              elevation: 8,
                              shadowColor: Colors.white70,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  side: BorderSide(
                                      width: 2, color: Colors.white24)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.location_on),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${_currentAddress ?? ""}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      ),
                                    ])),
                              )),

                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              height: 60.0,
                              width: size.width * .6,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                  ),
                                  onPressed: () {
                                    //MakingRequest();
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => Search(
                                    //             title: widget.title,
                                    //             image: widget.image)));
                                    // availableArtisans = GeoFireAssistant
                                    //     .nearByAvailableArtisansList;
                                    // searchNearestArtisans();
                                  },
                                  child: Text(
                                    "Complete request",
                                    style: TextStyle(
                                        fontSize: 20,
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

  MakingRequest() {
    request = FirebaseDatabase.instance.reference().child("Request").push();

    Map rideInfoMap = {
      "client_phone":
          Provider.of<Client>(context, listen: false).riderInfo?.phone,
      "created_at": DateTime.now().toString(),
      'client_name':
          Provider.of<Client>(context, listen: false).riderInfo?.firstname!,
      'RequestName': requestTitlecontroller.text.toString(),
      'Description': Descriptioncontroller.text.toString(),
      'Location': _currentAddress?.trim().toString(),
      'Service Type': widget.title.toString(),
      'finalClient_address': _currentAddress?.trim().toString(),
    };

    request?.set(rideInfoMap);
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