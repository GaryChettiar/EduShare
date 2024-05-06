import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService{
  final CollectionReference notes = FirebaseFirestore.instance.collection('Project Information (Responses)');

  Future<void> addNode(String note){
    return notes.add({
      'note':note,
      'timestamp':Timestamp.now(),
    });
  }

  Stream<QuerySnapshot<Object?>> getNotesStream(){
    final noteStream= notes.limit(10).orderBy('Name',descending: false).snapshots();
    return noteStream;
  }
  }
