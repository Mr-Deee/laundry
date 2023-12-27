import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry/models/Client.dart';
import 'package:provider/provider.dart';
import '../models/washreq.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {

  void initState() {

    super.initState();
    // getPicture();

    _fetchUserRequests();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      body : Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Column(
              children: [
                SizedBox(height: 50,),
                 Center(child: Text("Laundry Status",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),))
              ],
            ),
          
              SizedBox(
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
                  trailing:Text(request.status),
                  // GestureDetector(
                  //   onTap: () {
                  //     // setState(() {
                  //     //   if (request.status == "Pending") {
                  //     //
                  //     //     request.status = "started";
                  //     //
                  //     //   } else {
                  //     //     request.status = "finish";
                  //     //   }
                  //     // });
                  //     //
                  //     // _updateRequestStatus(index, request.status);
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(8),
                  //     decoration: BoxDecoration(
                  //       color: Colors.blue,
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: Text(
                  //       request.status == "started" ? "Finish" : "Start",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                ));
          },
                ),
              ),
          
          
          
          
          ],),
        ),
      )
    );
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Request> _userRequests = [];
  Future<void> _fetchUserRequests() async {
    if (_auth.currentUser != null) {
      print("got your request+'${_auth.currentUser?.email}'");
      final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('Request');
      final username=  Provider.of<Client>(context, listen: false).riderInfo?.firstname;

      final DatabaseEvent event = await databaseReference
          .orderByChild('UserName')
          .equalTo(username)
          .once();

      // print("ggg" + '${username}');

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
      });
    }
  }
}
