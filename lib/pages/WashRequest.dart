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

    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      body:FutureBuilder(
        future: fetchData(),
        builder: (context, event) {
          if (event.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (event.hasError) {
            return Text('Error: ${event.error}');
          } else {
            List<Map<String, dynamic>> dd =
            event.data as List<Map<String, dynamic>>;
            print(dd);
            return ListView.builder(
              itemCount: dd.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ItemNames: ${dd[index]['UserName']}'),
                      // Text('Status: ${data[index]['status']}'),
                      // Text('Date: ${data[index]['created_at']}'),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            dd[index]['status'] = 'Started';
                          });
                          // Call your function to update status
                          // updateStatus('your_wash_request_id', 'Started');
                        },
                        child: Text('Start'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            dd[index]['status'] = 'Finished';
                          });
                          // Call your function to update status
                          // updateStatus('your_wash_request_id', 'Finished');
                        },
                        child: Text('Finish'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      )

    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    // Replace 'yourReference' with the path to your data in the Realtime Database
    DatabaseEvent event = await FirebaseDatabase.instance
        .ref()
        .child('Request')
        .orderByChild('Service Type')
        .equalTo('wash')
        .once();

    List<Map<String, dynamic>> data = [];
    Map<dynamic, dynamic>? values = event.snapshot.value as Map?;

    if (values != null) {
      values.forEach((key, item) {
        // You can customize this part based on your data structure
        data.add(Map<String, dynamic>.from(item));
      });
    }

    return data;
  }
}





