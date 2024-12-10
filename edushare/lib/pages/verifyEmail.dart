import 'dart:async';

import 'package:edushare/main.dart';
import 'package:edushare/pages/Registration.dart';
import 'package:edushare/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  const VerificationPage({super.key, required this.email, required this.password, required this.name});

  @override
  State<VerificationPage> createState() => _VerificationPageState(email: email, password: password,name: name);
}

class _VerificationPageState extends State<VerificationPage> {
  final String name;
  final String email;
  final String password;
  bool wait=false;
  bool canResendEmail=false;
   bool isEmailVerified=false;
   Timer? timer;

  _VerificationPageState( {required this.email, required this.password,required this.name,});
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified= FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified)  {
      sendVerificationEmail();

      timer= Timer.periodic(
          Duration(seconds: 3),
          (_)=>checkEmailVerified(),
      );
    }
  }

Future checkEmailVerified()async{
  await FirebaseAuth.instance.currentUser!.reload();
  var user=FirebaseAuth.instance.currentUser;
  setState(() {
    isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
    if(isEmailVerified){
      timer?.cancel();
      
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register2(email: email,password: password,user:user!,name : name )));
    }
  });
}
  Future sendVerificationEmail()async{
    try{
    final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false); 
await Future.delayed (Duration (seconds: 5));
setState(() => canResendEmail = true);
    }
    catch(e){

    }
    
  }
   
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
           image: DecorationImage(
            image: AssetImage('assets/bgbg.png'),
            fit: BoxFit.cover,
          ),),
          child: Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width*0.9,
              child: Container(
                color:Color.fromARGB(167, 245, 245, 245),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  
                  children: [
                    Text("An verification email has been sent to your email address",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black,fontSize: 20),),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                    "Did not recieve email?",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                    ),
                    ElevatedButton(onPressed: canResendEmail? sendVerificationEmail:() {
                      setState(() {
                        wait=true;
                      });
                    }, 
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                    child: wait?Text("Please wait for 5s"): Text("Resend email")
                    
                    ),
                    ElevatedButton(onPressed: canResendEmail? sendVerificationEmail:() {
                      setState(() {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>landing()));
                      });
                    }, 
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                    child: Text("Cancel"))
                        
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}