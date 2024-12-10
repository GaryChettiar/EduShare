import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier{
late String senderName;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message

  Future<void> sendMessage(String receiverUserId, String message)async {
    // get current user info
final String currentUserId =  _firebaseAuth.currentUser!.uid;
final String currentUserEmail =  _firebaseAuth.currentUser!.email.toString();
final Timestamp timestamp = Timestamp.now();
QuerySnapshot userSnapshot = await FirebaseFirestore.instance.collection('Users').where('uid', isEqualTo: currentUserId).get();
    if (userSnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = userSnapshot.docs.first;
      senderName = userDoc.get('username');
    }
    // create a new message
Message newMessage = Message(
  senderName:senderName,
  senderId: currentUserId, 
  senderEmail: currentUserEmail, 
  receiverId: receiverUserId, 
  message: message, 
  timestamp: timestamp);
  
  
    //construct chatroom id

    List <String> ids = [currentUserId, receiverUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
  
  
    // add new message to data set

    await _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').add(newMessage.toMap());


  }

  //get message
  Stream<QuerySnapshot> getMessages (String userId, String otherUserId) {
// construct chat room id from user ids (sorted to ensure it matches the id
        List<String> ids = [userId, otherUserId];
        ids.sort();
        String chatRoomId = ids.join("_");
        return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
}
}