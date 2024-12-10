
import 'package:edushare/pages/Registration.dart';
import 'package:edushare/pages/login.dart';
import 'package:edushare/pages/pref.dart';
import 'package:flutter/material.dart';

class LoggedOut extends StatelessWidget {
  const LoggedOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/bg_login.jpg'),fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height*0.8,
              ),
              Row(
                children: [
                  Align(child: Image.asset('assets/logo.png' ,height: 25,width: 22,fit: BoxFit.fill,),alignment: Alignment.topCenter,),
                  SizedBox(width: 10,),
                  Align(
                    child: Text("EDUshare",style: TextStyle(
                      fontFamily: "Comfortaa",
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      
                    ),
                    textAlign:TextAlign.center,
                      
                    ),
                    alignment: Alignment.bottomCenter,
    
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                      },
                      child: Container(
                        height: 52,
                        width: 167,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2,color: Colors.black,style: BorderStyle.solid,strokeAlign: BorderSide.strokeAlignInside),
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child: Center(child: Text("LOG IN",style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Roboto",
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                        ),)),
                      ),
                    ),
                    
                     InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Pref()));
                      },
                      child: Container(
                        height: 52,
                        width: 167,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(width: 2,color: Colors.black,style: BorderStyle.solid,strokeAlign: BorderSide.strokeAlignInside),
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child: Center(
                          child: Text("REGISTER",style: TextStyle(color: Colors.white,
                          fontFamily: "Roboto",
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    )
    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}