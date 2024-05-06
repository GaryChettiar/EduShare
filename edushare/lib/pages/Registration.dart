import 'package:edushare/pages/home.dart';
import 'package:flutter/material.dart';

class Register1 extends StatefulWidget {
  const Register1({super.key});

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {

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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Register2()));
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
      ),
    );
  }
}

class RegInput extends StatelessWidget {
  const RegInput({
    required this.text,
    super.key,
    required this.email,
  });

  final TextEditingController email;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: MediaQuery.sizeOf(context).height*0.064,
      width: MediaQuery.sizeOf(context).width*0.914,
      
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black,width: 2,
        strokeAlign: BorderSide.strokeAlignInside,
        
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          onSubmitted: (value) {
            email.clear();
          },
          controller: email,
          decoration: InputDecoration(
            hintText:text,
            border: InputBorder.none
          ),
        ),
      ));
  }
}

class Register2 extends StatefulWidget {
  const Register2({
    
    super.key});

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {

  final TextEditingController user = new TextEditingController();

  _Register2State();

  @override
  Widget build(BuildContext context) {
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
              

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
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