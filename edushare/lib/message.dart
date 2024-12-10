import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderName;
  final String senderId;
final String senderEmail;
final String receiverId;
final String message;
final Timestamp timestamp;
Message( {required this.senderId, required this.senderEmail,required this.receiverId,required this.message, required this.timestamp, required  this.senderName});

//convert to a map
Map<String, dynamic> toMap() {
   
    return{
      'senderName':senderName,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      };
}}