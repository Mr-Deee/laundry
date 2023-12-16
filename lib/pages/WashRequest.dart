import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class washrequest extends StatefulWidget {
  const washrequest({super.key});

  @override
  State<washrequest> createState() => _washrequestState();
}

class _washrequestState extends State<washrequest> {
  DatabaseReference? _databaseReference;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('Request');
    print(_databaseReference);

    Getrequest();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      body:Container(
        child: Column(
          children: [
            Text(""),
        Center(
          child: Center(
            child: FutureBuilder<DatabaseEvent>(
              // Replace 'your_wash_request_id' with an actual request ID from your database
              future: _databaseReference?.once(),
              builder: (context, AsyncSnapshot<DatabaseEvent> event) {
                if (event.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (event.hasError) {
                  return Text('Error: ${event.error}');
                } else {
                  Map<dynamic, dynamic>? requestData = event.data?.snapshot.value as Map<dynamic, dynamic>?;
                  if (requestData != null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('Name: ${requestData['name']}'),
                        Text('ItemNames: ${requestData['UserName']}'),
                        // Text('Count: ${requestData['count']}'),
                        Text('Status: ${requestData['status']}'),
                        Text('Date: ${requestData['created_at']}'),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Set status to 'Started' on button tap
                            // updateStatus('your_wash_request_id', 'Started');
                            setState(() {
                              requestData['status'] = 'Started';
                            });
                          },
                          child: Text('Start'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Set status to 'Finished' on button tap
                            // updateStatus('your_wash_request_id', 'Finished');
                            setState(() {
                              requestData['status'] = 'Finished';
                            });
                          },
                          child: Text('Finish'),
                        ),
                      ],
                    );
                  } else {
                    return Text('No wash requests found.');
                  }
                }
              },
            ),
          ),
        ),
            Row(children: [


            ],)
          ],
        ),

      )
    );
  }




   void Getrequest(){
     _databaseReference = FirebaseDatabase.instance.ref().child('Request');
     // Add listener to the database reference
     _databaseReference?.onValue.listen((DatabaseEvent event) {
       // Handle the data from the database
       Map<dynamic, dynamic>? requests = event.snapshot.value as Map?;
       if (requests != null) {
         // Filter requests where service type is equal to 'wash'
         List washRequests = requests.keys
             .where((key) => requests[key]['Service Type'] == 'Wash')
             .toList();
         print('Wash Requests: $washRequests');
       }
     });

  }
}
