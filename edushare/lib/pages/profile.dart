import 'dart:math';

import 'package:edushare/pages/loggedout.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser;
  late String _userName;
  late String _pfp;
  late String _name;
  List<Project>? _projects = [];
  bool _isDataFetched = false;
  Future<void>? _future;
//late bool isMale;
  @override
  void initState() {
    super.initState();
    _future = _fetchData();
    // _getCurrentUser();
  }

  Future<void> _fetchData() async {
    await _getCurrentUser();
    await getProjects();
    setState(() {
      _isDataFetched = true;
    });
  }

  Future<void> getProjects() async {
    print("getProjects");
    await _fetchProjects();
  }

  Future<void> _getCurrentUser() async {
    print("currentUser");
    _currentUser = _auth.currentUser;
    if (_currentUser != null) {
      await _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    QuerySnapshot userSnapshot = await _firestore
        .collection('Users')
        .where('email', isEqualTo: _currentUser!.email)
        .get();
    if (userSnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = userSnapshot.docs.first;
      _userName = userDoc['username'];
      _name = userDoc['name'];
      _pfp = userDoc['pfp'];
      //  isMale = userDoc['isMale'];
    }
  }

  Future<void> _fetchProjects() async {
    print("i was here");
    QuerySnapshot userSnapshot = await _firestore
        .collection('Users')
        .where('email', isEqualTo: _currentUser!.email)
        .get();

    QuerySnapshot projectSnapshot = await _firestore
        .collection('Users')
        .doc(userSnapshot.docs.first.id)
        .collection('Projects')
        .where('isDummy', isEqualTo: false)
        .get();
    _projects = projectSnapshot.docs
        .map((doc) => Project(
              name: doc['name'],
              description: doc['desc'],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // print(_projects);
    // if (_projects == null) {
    //   print("projects is null");
    // }
    // if (!_isDataFetched) {
    //   return Center(child: CircularProgressIndicator());
    // }
    print(_projects);
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_isDataFetched) {
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  body: SafeArea(
                    child: Center(
                      child: _currentUser == null
                          ? CircularProgressIndicator() // Display loading indicator while fetching data
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                            Icons.arrow_back_ios_new_rounded)),
                                    Text(
                                      'Welcome, $_userName!',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoggedOut()),
                                          );
                                        },
                                        icon: Icon(Icons.logout))
                                  ],
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        child: Image.asset(_pfp),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(_name)
                                    ],
                                  ),
                                ),
                                Divider(),
                                SizedBox(
                                  height: 10,
                                ),
                                TabBar(tabs: [
                                  Tab(
                                    child: Text('My Projects'),
                                  ),
                                  Tab(
                                    child: Text('Collaborative Projects'),
                                  ),
                                ]),
                                SizedBox(height: 20),
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      ListView.builder( padding: EdgeInsets.all(10),
                                        itemCount: _projects?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return  Container(
                                            margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 8),
                                                      child: Text(
                                                        _projects?[index]
                                                                .name ??
                                                            "",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      _projects?[index]
                                                              .description ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            
                                          );
                                        },
                                      ),
                                      ListView.builder(
                                        itemCount: _projects?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 8),
                                                      child: Text(
                                                        _projects?[index]
                                                                .name ??
                                                            "",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                      _projects?[index]
                                                              .description ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Project {
  final String name;
  final String description;

  Project({required this.name, required this.description});
}
