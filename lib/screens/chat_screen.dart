// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chatty_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  var textController = TextEditingController();
  final _scrollController = ScrollController();
  String email;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  ChatScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages
            .orderBy(
              kCreatedAt,
              descending: true,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      appLogo,
                      width: 30,
                      height: 30,
                    ),
                    Text('  Chat')
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) =>
                          messagesList[index].id == email
                              ? ChattyBubble(
                                  userMessage: messagesList[index].message,
                                  userEmail: messagesList[index].id,
                                )
                              : ChattyBubbleForFriend(
                                  userMessage: messagesList[index].message,
                                  userEmail: messagesList[index].id,
                                ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50, left: 10, right: 10,),
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'Message..',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (textController.text.isNotEmpty) {
                              messages.add({
                                kMessage: textController.text,
                                kCreatedAt: DateTime.now(),
                                'id': email,
                              });
                              textController.clear();
                              _scrollController.animateTo(
                                0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.bounceIn,
                              );
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      appLogo,
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Chat'),
                  ],
                ),
              ),
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
