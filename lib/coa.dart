import 'package:flutter/material.dart';

class Chatwithotheradmins extends StatefulWidget{
  const Chatwithotheradmins({super.key});

  @override
  ChatwithotheradminsState createState() => ChatwithotheradminsState();
}


class ChatwithotheradminsState extends State<Chatwithotheradmins>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 181, 120),
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
          ],
        ),
      ),
      body:Center(child: Text("data"))
    );
  }

}