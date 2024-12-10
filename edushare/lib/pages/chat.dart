import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/pages/chatpage.dart';
import 'package:edushare/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  User? _currentUser;
  late String _pfp;

void setupPushNotifications() async{
  final fcm = FirebaseMessaging.instance;

  await fcm.requestPermission();
  final token = await fcm.getToken();
  print(token);
}

  Future<void> _fetchUserData() async {
    _currentUser = FirebaseAuth.instance.currentUser;

    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: _currentUser!.email)
        .get();
    if (userSnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = userSnapshot.docs.first;
      setState(() {
        _pfp = userDoc['pfp'];
        //  isMale = userDoc['isMale'];
      });
    }
  }

  late bool isMale;
  int currentIndex = 0;
  ontapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchUserData();
    setupPushNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        child: Image.asset(
                          'assets/logo.png',
                          height: 30,
                          width: 30,
                          fit: BoxFit.fill,
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Align(
                        child: Text(
                          "EDUshare",
                          style: TextStyle(
                            fontFamily: "Comfortaa",
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    var auth = FirebaseAuth.instance;
                    //auth.signOut();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>landing()));
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(_pfp),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Color.fromARGB(63, 0, 0, 77),
          ),
          Expanded(child: _buildUserList())
        ],
      ),
    );
  }

// build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        ); // ListView I
      },
    ); // StreamBuilder
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (FirebaseAuth.instance.currentUser!.email != data['email']) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverPfp: data['pfp'],
                receiverUserName: data['username'],
                receiverUserId: data['uid'],
              ), // ChatPage
            ), // MaterialPageRoute
          );
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(10),
          height: 120,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color.fromARGB(63, 0, 0, 77)))),
          width: MediaQuery.sizeOf(context).width,
          child: Row(children: [
            CircleAvatar(
              radius: 35,
              child: Image.asset(data['pfp']),
            ),
            SizedBox(
              width: 20,
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    data['username'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )),
          ]),
        ),
      );
    } else {
      return Container(
        color: Colors.blue,
        height: 0,
        width: MediaQuery.sizeOf(context).width,
      );
    }
  }
}
