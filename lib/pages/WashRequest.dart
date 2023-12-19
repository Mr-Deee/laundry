
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  void initState() {
    // username=  Provider.of<Client>(context, listen: false).?.firstname;

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

      if (event.snapshot.value != null&& event.snapshot.value is Map) {
        ( event.snapshot.value as Map).forEach((key, value) {
          // Assuming Request class has appropriate constructor to extract data
          // Adjust this part based on your actual Request class structure
          Request request = Request(
            title: value['UserName'],
            title: value['UserName'],
            description: value['created_at'],
            amount: value['Amount'].toString(),
            count: value['selectedItemCount'],
          );
          requests.add(request);
        });
      }

      setState(() {
        _userRequests = requests;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // username = Provider.of<Users>(context,listen: false).userInfo?.Username??"";
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(

      body: Column(
        children: [
          SizedBox(height: 45,),
          Column( children: [Text("Wash Requests",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),)]),
          SizedBox(
            height: screenWidth / 0.67,

            child: ListView.builder(
              itemCount: _userRequests.length,
              itemBuilder: (context, index) {
                final request = _userRequests[index];
                return Card(
                  elevation: 4, // Controls the shadow of the card.
                  color: Colors.white,
                  margin: EdgeInsets.all(16), // Margin around the card.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners.
                  ),

                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                          image: AssetImage(
                            "assets/images/wash.png",),
                          height: 60,
                        ),
                        Text(request.title),
                        Text(request.count),
                      ],
                    ),
                    subtitle: Text(request.description),
                trailing: GestureDetector(
                onTap: () {
                // Update the status when the button is tapped.
                setState(() {
                if (request.status == "started") {
                request.status = "finish";
                } else {
                request.status = "started";
                }
                });
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
                );
              },
            ),
          ),

        ],
      ),
    );
  }





  }







