import 'package:edushare/pages/Registration.dart';
import 'package:edushare/pages/home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

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
                  child: RegInput(email: email,text: "Email",)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RegInput(email: password,text: "Password",)),
              ),

              InkWell(

                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
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