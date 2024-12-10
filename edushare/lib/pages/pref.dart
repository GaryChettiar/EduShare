import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Pref extends StatelessWidget {
  const Pref({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text("Choose any 3",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
            ),
            SizedBox(height: 25),
            SizedBox(height: 70,width: MediaQuery.sizeOf(context).width*.9,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 50,width: 150 ,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),border:Border.all(width:2)), child: Center(child: Text("Computer Science")),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 50,width: 150,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),border:Border.all(width:2)),
                  child: Center(child: Text("Cloud Computing ")),),
                ),
                
                
              ],),
            ),
            SizedBox(height: 70,width: MediaQuery.sizeOf(context).width*.9,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 50,width: 190,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),border:Border.all(width:2)), child: Center(child: Text("Mechanical & Autmoblile")),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 50,width: 120,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),border:Border.all(width:2)), child: Center(child: Text("Biotechnology")),),
                ),
                
              ],),
            ),
            SizedBox(height: 70,width: MediaQuery.sizeOf(context).width*.9,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 50,width: 250,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),border:Border.all(width:2)), child: Center(child: Text("Electronics & Communication ")),),
                ),
                
                
              ],),
            ),
            SizedBox(height: 70,width: MediaQuery.sizeOf(context).width*.9,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 50,width: 220,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),border:Border.all(width:2)), child: Center(child: Text("Electrical and Electronics ")),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 50,width: 100,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),border:Border.all(width:2)), child: Center(child: Text("AI/ML ")),),
                ),
               
              ],),
            ),
            SizedBox(height: 70,width: MediaQuery.sizeOf(context).width*.9,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 50,width: 120,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),border:Border.all(width:2)), child: Center(child: Text("Data Science")),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 50,width: 120,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),border:Border.all(width:2)), child: Center(child: Text("Robotics ")),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 50,width: 65,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),border:Border.all(width:2)), child: Center(child: Text("IoT")),),
                ),
               
              ],),
            ),
            SizedBox(height: 70,width: MediaQuery.sizeOf(context).width*.9,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 50,width: 120,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)),border:Border.all(width:2)), child: Center(child: Text("CyberSecurity")),),
                ),
                
               
              ],),
            ),Spacer(),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label:Text("Next ") ),
      ),
    );
  }
}