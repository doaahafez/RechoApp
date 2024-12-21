import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {

  final reseiverId;

  const ChatScreen({super.key,this.reseiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _TextController =TextEditingController();

  final DatabaseReference _messagesRef = FirebaseDatabase.instance.ref().child('Messages');

  late final uid;

  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;
    uid = user!.uid;

    print("UID FROM ChatScreen $uid");
  }

  void _sendMessage() {
    if (_TextController.text.isNotEmpty) {
      _messagesRef.push().set({
        "SenderId" : uid,
        "ReceverId": widget.reseiverId,
        'message': _TextController.text,
        "Created At": DateTime.timestamp().toString(),
      });
      _TextController.clear();
    }else{
      print("Complete your data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight, // Aligns the title to the right
          child: Text(
            "دردشة",
            style: TextStyle(fontSize: 20),
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,

      ),

      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _messagesRef.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData) {
                  List<Map<String, dynamic>> messages = [];
                  List<Map<String, dynamic>> messagesToShow = [];
                  if (snapshot.data!.snapshot.value != null) {
                    final data = Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
                    messages = data.values.map((e) => Map<String, dynamic>.from(e)).toList();
                    // messages = messages.reversed.toList();

                    for (int i = 0; i < messages.length; i++) {
                      if ((messages[i]['SenderId'] == widget.reseiverId && messages[i]['ReceverId'] == uid) ||
                          (messages[i]['SenderId'] == uid && messages[i]['ReceverId'] == widget.reseiverId)) {
                        messagesToShow.add(messages[i]);
                      }
                    }

                    messagesToShow.sort((a, b) => b['Created At'].compareTo(a['Created At']));;
                    messagesToShow = messagesToShow.reversed.toList();

                    if(messagesToShow.isEmpty){
                      return Center(child: Text("لا يوجد رسائل "));
                    }
                    return ListView.builder(
                      itemCount: messagesToShow.length,
                      itemBuilder: (context, index) {
                        final message = messagesToShow[index]['message'];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          child: Align(
                            alignment:messagesToShow[index]["ReceverId"] == widget.reseiverId ? Alignment.topRight : Alignment.topLeft,
                            child: Card(
                              color: messagesToShow[index]["ReceverId"] == widget.reseiverId ? Colors.blueAccent : Colors.grey.shade200 ,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4),
                                    Text(message,
                                      style: TextStyle(fontSize: 14,  color: messagesToShow[index]["ReceverId"] == widget.reseiverId ? Colors.white : Colors.black ,
                                          fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("لا يوجد رسائل ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),));
                  }
                }else{
                  return Center(child: Text("لا يوجد رسائل ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),));
                }
                // return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
    child: Row(
      children: [
        GestureDetector(
          onTap: _sendMessage, // Correct usage of onTap
          child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center, // Centers the Text widget both vertically and horizontally
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightBlueAccent,
            ),
            child: Text(
              "إرسال",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center, // Text alignment
            ),
          ),
        ),

        SizedBox(width: 8),
        Expanded(

          child: TextField(
            textAlign: TextAlign.right,
            controller: _TextController,
            decoration: InputDecoration(
              hintText: "اكتب رسالتك",
              fillColor: Colors.white,
              filled: true,
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),


        // IconButton(
        //   icon: Icon(Icons.send, color: Colors.blue),
        //   onPressed: _sendMessage,
        // ),

      ],
    ),
    ),

          ),
        ],
      ),



    );
  }
}
