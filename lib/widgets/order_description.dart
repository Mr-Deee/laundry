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
  // TextEditingController requestTitlecontroller = TextEditingController();
  // TextEditingController Descriptioncontroller = TextEditingController();
  Map<String, int> itemCountMap = {};

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

  String? selectedItemImage;
  String? selectedItemTitle;
  String? selectedItemTitle2;
  String? selectedItemTitle3;
  String? selectedItemTitle4;
  String? selectedItemTitle5;
  String? selectedItemCount;

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
                                  onItemSelected: (name, image, count) => {
                                        setState(() {
                                          selectedItemTitle = name;
                                          selectedItemImage = image;
                                          selectedItemCount = count.toString();
                                          itemCountMap[selectedItemTitle
                                                  .toString()] =
                                              int.parse(
                                                  selectedItemCount.toString());
                                        }),
                                      }),
                              item_selection(
                                  image: 'assets/images/tshirt.png',
                                  title: 'T-Shirt',
                                  onItemSelected: (name, image, count) => {
                                        setState(() {
                                          selectedItemTitle = name;
                                          selectedItemImage = image;
                                          selectedItemCount = count.toString();
                                          itemCountMap[selectedItemTitle
                                                  .toString()] =
                                              int.parse(
                                                  selectedItemCount.toString());
                                        }),
                                      }),
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
                                  onItemSelected: (name, image, count) => {
                                        setState(() {
                                          selectedItemTitle = name;
                                          selectedItemImage = image;
                                          selectedItemCount = count.toString();
                                          itemCountMap[selectedItemTitle
                                                  .toString()] =
                                              int.parse(
                                                  selectedItemCount.toString());
                                        }),
                                      }),
                              item_selection(
                                  image: 'assets/images/trousers.png',
                                  title: 'Trouser',
                                  onItemSelected: (name, image, count) => {
                                        setState(() {
                                          selectedItemTitle = name;
                                          selectedItemImage = image;
                                          selectedItemCount = count.toString();
                                          itemCountMap[selectedItemTitle
                                                  .toString()] =
                                              int.parse(
                                                  selectedItemCount.toString());
                                        }),
                                      }),
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
                                onItemSelected: (name, image, count) => {
                                  setState(() {
                                    selectedItemTitle = name;
                                    selectedItemImage = image;
                                    selectedItemCount = count.toString();
                                    itemCountMap[selectedItemTitle.toString()] =
                                        int.parse(selectedItemCount.toString());
                                  })
                                },
                              ),
                              item_selection(
                                  image: 'assets/images/blouse.png',
                                  title: 'Blouse',
                                  onItemSelected: (name, image, count) => {
                                        setState(() {
                                          selectedItemTitle = name;
                                          selectedItemImage = image;
                                          selectedItemCount = count.toString();

                                          // Update itemCountMap when an item is selected
                                          itemCountMap[selectedItemTitle
                                                  .toString()] =
                                              int.parse(
                                                  selectedItemCount.toString());
                                        }),
                                      })
                            ],
                          ),

                          const SizedBox(
                            height: 10,
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
                                    MakingRequest();
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
    request = FirebaseDatabase.instance.ref().child("Request").push();

    // Create a list to store the selected items
    List<Map<String, dynamic>> selectedItemsList = [];

    // Create a list to store the selected items
    // Add each selected item with its count to the list
    for (var entry in itemCountMap.entries) {
      selectedItemsList.add({
        'title': entry.key,
        // 'count': entry.value,
      });
    }

    Map rideInfoMap = {
      // "client_phone":
      //     Provider.of<Client>(context, listen: false).riderInfo?.phone,
      "created_at": DateTime.now().toString(),
      // 'client_name':
      //     Provider.of<Client>(context, listen: false).riderInfo?.firstname!,
      // 'SelectedItem': [
      //   selectedItemTitle,
      //   selectedItemTitle2,
      //   selectedItemTitle3,
      //   selectedItemTitle4,
      //   selectedItemTitle5
      // ],
      'selectedItemImage': selectedItemImage,
      //New addition
      'SelectedItems2': selectedItemsList,
      'selectedItemCount': selectedItemCount,
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
