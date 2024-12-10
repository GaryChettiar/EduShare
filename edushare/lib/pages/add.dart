import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addProject extends StatefulWidget {
  const addProject({super.key});

  @override
  State<addProject> createState() => _addProjectState();
}

class _addProjectState extends State<addProject> {
  @override
  Widget build(BuildContext context) {
    String status = '';
    String Username = '';
    String? userId;
    Future<DocumentSnapshot?> getUserByEmail(String email) async {
      try {
        CollectionReference users =
            FirebaseFirestore.instance.collection('Users');
        QuerySnapshot querySnapshot =
            await users.where('email', isEqualTo: email).get();
        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.first;
        } else {
          return null;
        }
      } catch (e) {
        print("Error getting user by email: $e");
        return null;
      }
    }

    void checkEmail(String? email) async {
      if (email != null) {
        DocumentSnapshot? userDoc = await getUserByEmail(email);
        if (userDoc != null && mounted) {
          setState(() {
            print(userDoc.id);
            //this.email = userDoc['email'].toString();
            //username = userDoc['username'].toString();
            userId = userDoc.id.toString();
          });
        } else {
          print("No user found with email: $email");
        }
      }
    }

    final TextEditingController name = new TextEditingController();
    final TextEditingController desc = new TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        child: Align(
          alignment: Alignment.center,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.cancel_outlined))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Add Project",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                    labelText: "Project Name",
                    focusedBorder: OutlineInputBorder(),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignInside))),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: TextField(
                controller: desc,
                decoration: InputDecoration(
                    labelText: "Project Description",
                    focusedBorder: OutlineInputBorder(),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignInside))),
              ),
            ),
            SizedBox(height: 40),
            DropdownMenu(
              width: MediaQuery.sizeOf(context).width * 0.8,
              inputDecorationTheme: InputDecorationTheme(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.black,
                      width: 0,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.black,
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  )),
              label: Text("Status"),
              dropdownMenuEntries: [
                DropdownMenuEntry(
                  value: 'On-Going',
                  label: 'On-Going',
                ),
                DropdownMenuEntry(
                  value: 'Completed',
                  label: 'Completed',
                ),
              ],
              onSelected: (value) {
                if (value == 'On-Going') {
                  status = 'On-Going';
                } else {
                  status = 'Completed';
                }
              },
            ),
            SizedBox(height: 25),
            InkWell(
              onTap: () async {
                DocumentSnapshot? x = await getUserByEmail(
                    FirebaseAuth.instance.currentUser!.email!);
                print(x!.id);
                CollectionReference collectionRef = FirebaseFirestore.instance
                    .collection('Users')
                    .doc(x.id)
                    .collection('Projects');
                await collectionRef.add({
                  'name': name.text,
                  'desc': desc.text,
                  'isDummy': false,
                  // 'email': 'john.doe@example.com'
                });
                QuerySnapshot userSnapshot = await FirebaseFirestore.instance
                    .collection('Users')
                    .where('email',
                        isEqualTo: FirebaseAuth.instance.currentUser!.email)
                    .get();
                if (userSnapshot.docs.isNotEmpty) {
                  DocumentSnapshot userDoc = userSnapshot.docs.first;
                  setState(() {
                    Username = userDoc['name'];
                    //  isMale = userDoc['isMale'];
                  });
                }
                CollectionReference projRef = FirebaseFirestore.instance
                    .collection('Project Information (Responses)');
                await projRef.add({
                  'Name': Username,
                  'Title of the Project': name.text,
                  'Describe your project/problem statement': desc.text,
                  'Status': status,
                  //'isDummy':false,
                  // 'email': 'john.doe@example.com'
                });

                name.clear();
                desc.clear();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));

                // if(username != null){
                // print("user logged in");

                //}else{
                // print('username is null');
                //}/*
                //*/
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.064,
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Roboto",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
            ),
          ]),
        ),
      )),
    );
  }
}

class addProjectWeb extends StatefulWidget {
  const addProjectWeb({super.key});

  @override
  State<addProjectWeb> createState() => _addProjectWebState();
}

class _addProjectWebState extends State<addProjectWeb> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
