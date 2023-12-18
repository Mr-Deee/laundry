import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String title;
  final String amount;
  final String count;
  final String description;

  Request({
      required  this.amount,
      required  this.count,
    required this.title,
    required this.description,
  });

  factory Request.fromDataSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Request(
      title: data['UserName'] ?? '',
      count: data['selectedItemCount']??'',
      amount:data['Amount']??'',
      description: data['UserName'] ?? '',
    );
  }
}