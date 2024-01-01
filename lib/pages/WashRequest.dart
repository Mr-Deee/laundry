import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/main.dart';
import 'package:provider/provider.dart';

import '../models/washreq.dart';

class washrequest extends StatefulWidget {
  const washrequest({super.key});

  @override
  State<washrequest> createState() => _washrequestState();
}

class _washrequestState extends State<washrequest> {
  DatabaseReference? _databaseReference;
  var username;
  bool _isLoading= true;
  void initState() {


    super.initState();
    // getPicture();

    _fetchUserRequests();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Request> _userRequests = [];

  Future<void> _fetchUserRequests() async {
    if (_auth.currentUser != null) {
      print("1gg+'${username}'");
      final DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref().child('Request');

      final DatabaseEvent event = await databaseReference
          .orderByChild('Service Type')
          .equalTo("Wash")
          .once();

      print("ggg" + '${username}');

      List<Request> requests = [];

      if (event.snapshot.value != null && event.snapshot.value is Map) {
        (event.snapshot.value as Map).forEach((key, value) {
          // Assuming Request class has appropriate constructor to extract data
          // Adjust this part based on your actual Request class structure
          Request request = Request(
            title: value['UserName'],
            status: value['Status'],
            description: value['created_at'],
            amount: value['Amount'].toString(),
            count: value['selectedItemCount'],
          );
          requests.add(request);
        });
      }

      setState(() {
        _userRequests = requests;
        _isLoading= false;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // username = Provider.of<Users>(context,listen: false).userInfo?.Username??"";
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          Column(children: [
            Text(
              "Wash Requests",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            )
          ]),
          _isLoading
              ? CircularProgressIndicator()
         : SizedBox(
            height: screenWidth / 0.67,
            child: ListView.builder(
              itemCount: _userRequests.length,
              itemBuilder: (context, index) {
                 var request = _userRequests[index];
                return Card(
                    elevation: 4,
                    // Controls the shadow of the card.
                    color: Colors.white,
                    margin: EdgeInsets.all(16),
                    // Margin around the card.
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners.
                    ),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage(
                              "assets/images/wash.png",
                            ),
                            height: 60,
                          ),
                          Text(request.title),
                          Text(request.count),
                        ],
                      ),
                      subtitle: Text(request.description),
                      trailing:
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (request.status == "Pending") {

                              request.status = "Started";

                            } else {
                              request.status = "Finish";
                            }
                          });
                          _updateRequestStatus(index, request.status);


                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            request.status == "started" ? "Finish" : "Start",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

// Function to update the request status in your data source
  void _updateRequestStatus(int index, String newStatus) {
    // Assuming _userRequests is a List of Request objects
    setState(() {
      _userRequests[index].status = newStatus;
    });

    // Update the request status in the Realtime Database
    request1.once().then((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? requestData = event.snapshot.value as Map<dynamic, dynamic>?;
        requestData?.forEach((key, value) {
          // Assuming 'key' is the key of the request to update
          if (value['Status'] == index) {
            print('Index: $index');
            request1.child(key)
                .update({'Status': newStatus})
                .then((_) {
              print('Status updated successfully in Realtime Database');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Status updated successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            })
                .catchError((error) {
              print('Error updating status in Realtime Database: $error');
            });
          }
        });
      } else {
        print('Request not found');
      }
    })
        .catchError((error) {
      print('Error querying database: $error');
    });
    // Add your database update logic here if needed
  }



}
