import 'package:flutter/material.dart';
import 'package:taibahcare/Screens/LoginScreen.dart';
import 'package:taibahcare/Style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _FireStore = FirebaseFirestore.instance;
User? loggedInUser;

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  var MessageText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.close,
                color: Color.fromARGB(255, 0, 191, 200),
              ),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Center(
          child: Text(
            'Quick Chat',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 191, 200),
              fontSize: 28,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: messageTextController,
                          decoration: ktextfield.copyWith(
                              hintText: 'Type your message here.'),
                          onChanged: (value) {
                            MessageText = value;
                          },
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            messageTextController.clear();
                            _FireStore.collection('message').add({
                              'text': MessageText,
                              'sender':
                                  FirebaseAuth.instance.currentUser!.email,
                              'datetime-send': DateTime.now().toString(),
                            });
                          },
                          child: const Text(
                            'Send',
                            style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          )),
                    ]),
              ),
            ]),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _FireStore.collection('message').orderBy('datetime-send').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          var data = message.data() as Map;
          final messageText = data['text'];
          final messageSender = data['sender'];

          final currentUser = FirebaseAuth.instance.currentUser!.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sender,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Material(
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
              elevation: 5.0,
              color: isMe
                  ? const Color.fromARGB(255, 0, 191, 200)
                  : Colors.white60,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}

// final _FireStore = FirebaseFirestore.instance;
//  User? loggedInUser;
//
// class Chat extends StatefulWidget {
//   @override
//   State<Chat> createState() => _ChatState();
// }
//
// class _ChatState extends State<Chat> {
//   final messageTextController = TextEditingController();
//   final _auth = FirebaseAuth.instance;
//   var MessageText;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         leading: null,
//         actions: <Widget>[
//           IconButton(
//           icon: Icon(Icons.close , color:Color.fromARGB(255, 0, 191, 200) ,),
//             onPressed: () {
//            _auth.signOut();
//           Navigator.pop(context);
//           }),
//              ],
//           title: Center(
//             child: Text('Quick Chat', style: TextStyle(
//               color: Color.fromARGB(255, 0, 191, 200),
//               fontSize: 28,
//             ),),
//           ),
//        backgroundColor: Colors.white,
//     ),
//         body: SafeArea(
//         child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           MessagesStream(),
//           Container(
//              child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//              Expanded(
//                child: TextField(
//                  controller: messageTextController,
//                  decoration: ktextfield.copyWith(hintText: 'Type your message here.'),
//               onChanged: (value){
//                 MessageText = value;
//               },
//     ),
//     ),
//                  TextButton(onPressed: (){
//                    messageTextController.clear();
//                    _FireStore.collection('message').add({'text': MessageText, 'sender': loggedInUser?.email});
//                  },
//                      child: Text('Send', style: TextStyle(
//                        color: Colors.teal,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 18.0,
//                      ),)),
//               ]
//     ),
//     ),
//     ]
//     ),
//     ),
//     );
//   }
// }
//
// class MessagesStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _FireStore.collection('messages').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasError) {
//           return Center(
//             // child: CircularProgressIndicator(
//             //   backgroundColor: Colors.lightBlueAccent,
//             // ),
//           );
//         }
//         final messages = snapshot.data!.docs.reversed;
//         List<MessageBubble> messageBubbles = [];
//         for (var message in messages) {
//           var data = message.data() as Map;
//           final messageText = data['text'];
//           final messageSender = data['sender'];
//
//           final currentUser = loggedInUser!.email;
//
//           final messageBubble = MessageBubble(
//             sender: messageSender,
//             text: messageText,
//             isMe: currentUser == messageSender,
//           );
//
//           messageBubbles.add(messageBubble);
//         }
//         return Expanded(
//           child: ListView(
//             reverse: true,
//             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//             children: messageBubbles,
//           ),
//         );
//       },
//     );
//   }
// }
//
// class MessageBubble extends StatelessWidget {
//   MessageBubble({Key? key, required this.sender, required this.text , required this.isMe});
//
//  final String sender;
//  final String text;
//  final bool isMe;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: < Widget> [
//           Text(sender, style: TextStyle(
//             fontSize: 12.0,
//             color: Colors.black54,
//           ),),
//        Material(
//         borderRadius: isMe ? BorderRadius.only(
//             topLeft: Radius.circular(30.0),
//             bottomLeft: Radius.circular(30.0),
//             bottomRight: Radius.circular(30.0))
//             : BorderRadius.only(
//           bottomLeft: Radius.circular(30.0),
//           bottomRight: Radius.circular(30.0),
//           topRight: Radius.circular(30.0),
//         ),
//         elevation: 5.0,
//          color: isMe ? Colors.lightBlueAccent : Colors.white,
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//           child: Text(text,
//           style: TextStyle(
//             color: isMe ? Colors.white : Colors.black54,
//             fontSize: 15.0,
//           ),),
//         ),
//       ),
//     ]
//     ),
//     );
//   }
// }

//
// class MessageStream extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder <QuerySnapshot>(
//       stream: _FireStore.collection('message').snapshots(),
//       builder: (context, snapshot){
//         if(snapshot.hasData){
//           return Center(
//             // child: CircularProgressIndicator(
//             //   backgroundColor: Colors.lightBlueAccent,
//             // ),
//           );
//         }
//         final messages = snapshot.data!.docs.reversed;
//         List<MessageBubble> messageBubbles = [];
//         for (var message in messages) {
//           final messageText = message['text'];
//           final messageSender = message['sender'];
//
//           final currentUser = loggedInUser!.email;
//
//           final messageBubble = MessageBubble(
//               sender: messageSender,
//               text: messageText,
//               isMe: currentUser == messageSender,
//           );
//
//           messageBubbles.add(messageBubble);
//         }
//         return Expanded(
//           child: ListView(
//             reverse: true,
//             padding: EdgeInsets.symmetric(vertical: 20.0 , horizontal: 10.0),
//             children: messageBubbles,
//           ),
//         );
//       },
//     );
//   }
// }
