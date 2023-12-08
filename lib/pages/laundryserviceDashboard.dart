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
      body: Column(children: [
        Row(
          children: [
            Container(
              child: Column(
                children: [
                  Text("Dashboard"),
                  Row(children: [
                    Text("Requests"),
                    Text("get from Db"),
                  ])
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}
