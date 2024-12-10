import 'package:edushare/pages/Registration.dart';
import 'package:edushare/pages/home.dart';
import 'package:edushare/pages/reg_web.dart';
import 'package:flutter/material.dart';


class Reg_web2 extends StatefulWidget {
  const Reg_web2({
    
    super.key});

  @override
  State<Reg_web2> createState() => Reg_web2State();
}

class Reg_web2State extends State<Reg_web2> {

  final TextEditingController user = new TextEditingController();

  Reg_web2State();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
Container(
      margin:  EdgeInsets.all(0),
      child:  Row(
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
                              color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        ),
                      ),
                    ),
                     SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.01,
                  ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Reg_Web_Input(email:  user,text: "Username",),
      ),
    
      InkWell(

                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
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
                          child: Text("SIGN UP",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
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
                color: const Color.fromARGB(255, 0, 0, 0),
              ),)
                   
                  ],
                ),
              ),
            )
        ],
      ),
    )
    );
  }
}
