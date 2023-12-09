import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class item_selection extends StatefulWidget {
  final String? image;
  final String? title;
  final Function(String name, String image, int count)? onItemSelected;

  const item_selection(
      {super.key, this.image, this.title, this.onItemSelected});

  @override
  State<item_selection> createState() =>
      _item_selectionState(image, title, onItemSelected);
}

class _item_selectionState extends State<item_selection> {
  final String? image;
  final String? title;

  final Function(String name, String image, int count)? onItemSelected;

  String? selectedLaundryItem;

  _item_selectionState(this.image, this.title, this.onItemSelected);
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 1500),
      child: Column(
        children: [
          Container(
            // duration: const Duration(milliseconds: 400),
            // scaleFactor: 1.5,
            // onPressed: ontap,
            child: Container(
              height: 160,
              width: 149,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white10,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, 1.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Column(
                children: [
                  Image(
                    image: AssetImage(
                      image!,
                    ),
                    height: 70,
                  ),
                  Text(
                    title!,
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                onItemSelected?.call(title!, image!, count);
                                incrementCounter();
                              },
                              child: Text(
                                '+',
                                style: TextStyle(fontSize: 23),
                              )),
                          Text(
                            '$count',
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                decrementCounter();
                              },
                              child: Text(
                                '-',
                                style: TextStyle(fontSize: 23),
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }
}
