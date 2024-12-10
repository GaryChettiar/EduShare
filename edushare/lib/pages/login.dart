import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/authservice.dart';
import 'package:edushare/pages/Registration.dart';
import 'package:edushare/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
final _auth = AuthService();
String username ="";
Future<DocumentSnapshot?> getUserByEmail(String email) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      QuerySnapshot querySnapshot = await users.where('email', isEqualTo: email).get();
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

 Future< void> checkEmail(String email) async {
  DocumentSnapshot? userDoc = await getUserByEmail(email);
  print('chekEmail CALLED');
  if (userDoc != null) {
    // Email found in Firestore
    print("User found: ${userDoc['username']}");
    setState(() {
      username=userDoc['username'].toString();

    });
    return;
  } else {
    // Email not found
    print("No user found with email: $email");
    return;
  }
}
   final TextEditingController email = new TextEditingController();
   final TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgbg.png'),
            fit: BoxFit.cover,
          ),),
          child: SafeArea(
            child: Column(
              
              children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Align(
                  child: Text("Login",style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontSize: 36,
                          fontWeight: FontWeight.bold
                  ),),
                  alignment: Alignment.centerLeft,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                child: Align(
                  alignment: Alignment.center,
                  child: RegInput(email: email,text: "Email",)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Align(
                  alignment: Alignment.center,
                  child: RegInput(email: password,text: "Password",)),
              ),

              InkWell(

                onTap: () async{
                  final _user = await _auth.loginUserWithEmail(email.text, password.text);
                  final user = FirebaseAuth.instance.currentUser;
                  print(email.text);
                 
                 
                  await checkEmail(email.text);
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
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
                        
                        height: MediaQuery.sizeOf(context).height*0.064,
                        width: MediaQuery.sizeOf(context).width*0.99,
                        
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black,width: 2,
                          strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child: Center(
                          child: Text("LOG IN",style: TextStyle(color: Colors.white,
                            fontFamily: "Roboto",
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),),
                        )),
                  ),
                ),
              ),
            ]),
          ),
      ),
    );
  }
}