import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/chat_service.dart';
import 'package:edushare/chatbubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserName;
  final String receiverUserId;
  final String receiverPfp;
  const ChatPage({super.key, required this.receiverUserName, required this.receiverUserId, required this.receiverPfp});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
late String senderPfp;
 Future<void> _fetchUserData() async {
                                User? _currentUser = FirebaseAuth.instance.currentUser;
                              
                                QuerySnapshot userSnapshot = await FirebaseFirestore.instance.collection('Users').where('email', isEqualTo: _currentUser!.email).get();
                                if (userSnapshot.docs.isNotEmpty) {
                                  DocumentSnapshot userDoc = userSnapshot.docs.first;
                                setState(() {
                                  senderPfp = userDoc['pfp'];
                                });
                                }
                               
                              }

  void sendMessage() async{
    if(_messageController.text.isNotEmpty)  {
      await _chatService.sendMessage(
        widget.receiverUserId, _messageController.text);
        _messageController.clear();
        
    }
  }
@override
  void initState() {
    // TODO: implement initState
    _fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        color: Color(0xfffaf2fb),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              color: Color(0xfffaf2fb),
              padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    child: Image.asset(widget.receiverPfp),
                  ),
                  SizedBox(width: 20,),
                  Text(widget.receiverUserName,style: TextStyle(
                    fontSize: 27,
                    color: Colors.black
                  ),),
                ],
              ),
            ),
          Divider(),
          Expanded(
            
            child: buildMessageList()),
          Container(
            padding: EdgeInsets.all(10),
            color: const Color(0xfffaf2fb),
            width: MediaQuery.sizeOf(context).width,
            height: 80,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 120,
                  width: MediaQuery.sizeOf(context).width*0.6,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Type a message",
                      floatingLabelStyle: TextStyle(fontSize: 0),
                    ),
                    controller: _messageController,
                    
                  ),
                ),
                InkWell(
                  onTap: (){
                    sendMessage();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                       color: Color.fromARGB(255, 158, 207, 247),
                       borderRadius: BorderRadius.circular(25),
                    ),
                   
                    child: Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageList() {
     
   
        return StreamBuilder(
          
        stream: _chatService.getMessages (
        widget.receiverUserId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
        if (snapshot.hasError) {
        return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text ('Loading..');
        }
        List<DocumentSnapshot> docs = snapshot.data!.docs;
      
      // Manually sort by timestamp to ensure correct order
      docs.sort((a, b) {
        Timestamp timeA = a['timestamp'];
        Timestamp timeB = b['timestamp'];
        return timeA.compareTo(timeB);
      });
        return ListView(
         
        children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),);
         // ListView
        },
        ); //StreamBuilder
        }

          Widget _buildMessageItem(DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            
         
            // align the messages to the right if the sender is the current user, otherwise to the left
            var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? Alignment.centerRight
              : Alignment.centerLeft;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: alignment,
                  child:  (data['senderId'] == _firebaseAuth.currentUser!.uid) ? 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                      children: [
                      Text (data['senderName'],style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),
                      
                      Chatbubble(message: data['message']),
                      ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        radius: 25,
                        child: Image.asset(senderPfp),
                      )
                    ],
                  ):
                  Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                      CircleAvatar(
                        radius: 30,
                        child: Image.asset(widget.receiverPfp),
                      ),
                       SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                      children: [
                      Text (data['senderName'],style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),
                      
                      Chatbubble(message: data['message']),
                      ],
                      ),
                    ],
                  ), // Column, // Column
            ); // Container
        }
}