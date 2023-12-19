import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String title;
  final String amount;
  late final String status;
  final String count;
  final String description;

  Request({
      required  this.amount,
      required  this.status,
      required  this.count,
    required this.title,
    required this.description,
  });

  factory Request.fromDataSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Request(
      title: data['UserName'] ?? '',
      status: data['Status'] ?? '',
      count: data['selectedItemCount']??'',
      amount:data['Amount']??'',
      description: data['UserName'] ?? '',
    );
  }
}