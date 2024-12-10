import 'package:flutter/material.dart';

class Chatbubble extends StatelessWidget {
  final String message;
  const Chatbubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
       constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width*0.6),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: Color.fromARGB(70, 0, 0, 0)
      ),
      child: Text(message),
    );
  }
}