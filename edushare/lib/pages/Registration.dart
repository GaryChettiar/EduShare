import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/authservice.dart';
import 'package:edushare/pages/home.dart';
import 'package:edushare/pages/reg_web.dart';
import 'package:edushare/pages/verifyEmail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register1 extends StatefulWidget {
 

   Register1({super.key});

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
      final _auth = AuthService();
final bool error=false;
   final TextEditingController email = new TextEditingController();
   final TextEditingController password = new TextEditingController();
   final TextEditingController name = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  (MediaQuery.sizeOf(context).width<800)? Container(
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
                  child: Text("Register",style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontSize: 36,
                          fontWeight: FontWeight.bold
                  ),),
                  alignment: Alignment.centerLeft,
                ),
              ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: RegInput(email: name,text: "Name",)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: RegInput(email: email,text: "Email",)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: RegInput(email: password,text: "Password",)),
              ),
              
              


              InkWell(

                onTap: ()async {
              final user = await _auth.createUserWithEmailAndPassword(email.text, password.text);
              if(user!=null){
                await user.sendEmailVerification();
                
                print("user created successfully");
                /*CollectionReference collRef =FirebaseFirestore.instance.collection('Users');
                      collRef.add({
                        'email': email.text,
                        'password':password.text
                      });*/
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> VerificationPage(email: email.text,password: password.text,name : name.text )));
                 
              }
                },

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        
                        height: MediaQuery.sizeOf(context).height*0.064,
                        width: MediaQuery.sizeOf(context).width*0.95,
                        
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black,width: 2,
                          strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child: Center(
                          child: Text("Next",style: TextStyle(color: Colors.white,
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
      ):Reg_web(),
    );
  }
}



class RegInput extends StatefulWidget {
  const RegInput({
    
    required this.text,
    super.key,
    required this.email,
  });

  
  final TextEditingController email;
  final String text;

  @override
  State<RegInput> createState() => _RegInputState();
}

class _RegInputState extends State<RegInput> {
  late String error=widget.text;
  late bool showPassword=false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 60,
      child: TextField(
          
            controller: widget.email,
            
            decoration: InputDecoration(
              
              labelText: widget.email.text.isEmpty?error:widget.text,
            
              labelStyle: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),
              fillColor: Colors.white,
              filled: true,
              
              disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2,strokeAlign: BorderSide.strokeAlignInside,)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2,strokeAlign: BorderSide.strokeAlignInside,)),
              border: OutlineInputBorder(
               borderSide: BorderSide(
    
                style: BorderStyle.solid,
                color: Colors.black,
                width: 5,
                strokeAlign: BorderSide.strokeAlignInside,
    ),
              ),
              suffix: (widget.text=="Password")?IconButton(padding: EdgeInsets.all(0),
                
                onPressed: (){
                  setState(() {
                    showPassword=!showPassword;
                  });
                }, icon: Icon(!showPassword?Icons.visibility:Icons.visibility_off,color: Colors.black,size:20 ,)):null
            
            ),
            
            obscureText: (widget.text=="Password")?(!showPassword):false,
            onChanged: (value) {
              if(value.isEmpty){
               setState(() {
                 
                 
               });
              }
            },
            
          ),
    );
  }
}

class Register2 extends StatefulWidget {
  final User user;
  final String email;
  final String password;
  final String name;
  const Register2({
    super.key,
    required this.email, required this.password, required this.user, required this.name,});

  @override
  State<Register2> createState() => _Register2State(email,password,user,name);
}

class _Register2State extends State<Register2> {
  final String name;
  List <String> avatarMale=[
    'assets/avatar1.png',
    'assets/avatar2.png',
    'assets/avatar4.png'
  ];
   List <String> avatarFemale=[
    'assets/avatar3.png',
    'assets/avatar5.png',
    'assets/avatar6.png'
  ];
  final User userx;
  String email;
  final String password;
  final TextEditingController user = new TextEditingController();
  
  

  _Register2State( this.email, this.password, this.userx, this.name);

  @override
  Widget build(BuildContext context) {

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

  void checkEmail(String? email) async {
    if (email != null) {
      DocumentSnapshot? userDoc = await getUserByEmail(email);
      if (userDoc != null && mounted) {
        print(userDoc.id);
      } else {
        print("No user found with email: $email");
      }
    }
  }

  checkEmail(email);
    bool isMale=true;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bgbg.png'),
          fit: BoxFit.cover,
          ),

        ),
        child: SafeArea(
            child: Column(
              
              children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Align(
                  child: Text("Register",style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontSize: 36,
                           fontWeight: FontWeight.bold
                  ),),
                  alignment: Alignment.centerLeft,
                ),
              ),
               
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RegInput(email: user,text: "Username",)),
              ),
             
              DropdownMenu(
                
                width: MediaQuery.sizeOf(context).width*0.94,
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
                  )
                ),
                label: Text("Gender"),
                dropdownMenuEntries: [
                DropdownMenuEntry(value: 'Male', label: 'Male',),
                DropdownMenuEntry(value: 'Female', label: 'Female',),
              ],
              onSelected: (value)  {
                if(value=='Male'){
                  setState(() {
                    isMale=true;
                    print(isMale);
                  });
                }
                else{
                  setState(() {
                    isMale=false;
                  });
                }
              },),



              InkWell(
                onTap: ()async {
                  if(user.text.isNotEmpty) {


                    CollectionReference collRef =FirebaseFirestore.instance.collection('Users');
                     
                      DocumentSnapshot? userDoc = await getUserByEmail(email);
      if (userDoc != null && mounted) {
         collRef.doc(userDoc.id).update({
          'username':user.text,
                        'email':email,
                        'password':password,
                        'isMale':isMale,
                        'pfp':isMale?avatarMale[Random().nextInt(3)+0]:avatarFemale[Random().nextInt(3)+0],
                        'name':name,
         });
      }else{
         collRef.add({
                        'username':user.text,
                        'email':email,
                        'password':password,
                        'isMale':isMale,
                        'pfp':isMale?avatarMale[Random().nextInt(3)+0]:avatarFemale[Random().nextInt(3)+0],
                        'name':name,
                        'uid':userx.uid,
                      });
      }
                     

                      print(collRef);
                      DocumentReference docRef =collRef.doc(userDoc!.id);
                      DocumentReference dummyDocRef = await docRef.collection('Projects').add({
                                  'placeholder': true,
                                  'createdAt': FieldValue.serverTimestamp(),
                                  'isDummy':true,
                                });
                                 
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                    
                  }else{
                    print("error");
                  }
                  
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        
                        height: MediaQuery.sizeOf(context).height*0.064,
                        width: MediaQuery.sizeOf(context).width*0.914,
                        
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black,width: 2,
                          strokeAlign: BorderSide.strokeAlignInside,
                          
                          ),
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child: Center(
                          child: Text("SIGN UP",style: TextStyle(color: Colors.white,
                            fontFamily: "Roboto",
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                  
                          ),),
                        )),
                  ),
                ),
              ),

              Text("By signing up, you agree to EDUshare’s Terms of Service and \nPrivacy Policy.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),)
            ]),
          ),
      ),
    );
  }
}