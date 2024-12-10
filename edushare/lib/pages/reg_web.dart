import 'package:edushare/authservice.dart';
import 'package:edushare/pages/Registration.dart';
import 'package:edushare/pages/reg_web2.dart';
import 'package:flutter/material.dart';

class Reg_web extends StatelessWidget {
  const Reg_web({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  

   final TextEditingController email = new TextEditingController();
   final TextEditingController password = new TextEditingController();
    return Container(
      margin: EdgeInsets.all(0),
      child: Row(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width*0.5,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/bg_login.jpg'),
                fit: BoxFit.cover)
                ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                 // gradient: LinearGradient(colors: [Colors.black,Colors.white10],begin: Alignment.topCenter,end: Alignment.bottomCenter),
                 border: Border.all(color: Colors.black,width: 2),
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [BoxShadow(color: Color.fromARGB(162, 0, 0, 0),offset: Offset(0, 4),blurRadius: 4),
                   BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ),]
                ),
                
                width: MediaQuery.sizeOf(context).width*0.45,
                child: Column(
                  children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.15,
                  ),
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Register",style: TextStyle(
                          
                        fontFamily: "Comfortaa",
                        fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        ),
                      ),
                    ),
                     SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.01,
                  ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Reg_Web_Input(email:  email,text: "Email",),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Reg_Web_Input(email:  password,text: "Password",),
      ),
      InkWell(

                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Reg_web2()));
                },

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        
                        height: MediaQuery.sizeOf(context).height*0.064,
                       width: 400,
                        
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 0, 0),
                          
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child: Center(
                          child: Text("Next",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: "Roboto",
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),),
                        )),
                  ),
                ),
              ),
                   
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}


class Reg_Web_Input extends StatelessWidget {
  const Reg_Web_Input({
    required this.text,
    super.key,
    required this.email,
  });

  final TextEditingController email;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      height:MediaQuery.sizeOf(context).height*0.064,
      width: MediaQuery.sizeOf(context).width*0.35,
      
    
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          obscureText: (text=='Password')?true:false,
          onSubmitted: (value) {
            email.clear();
          },
          controller: email,
          
          decoration: InputDecoration(
            hintText:text,
            
          ),
        ),
      ));
  }
}