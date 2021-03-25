import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userSnapshot = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('sendAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        final chatDocs = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, i) {
            return Container(
              padding: EdgeInsets.only(
                right: 6,
                bottom: 2,
                top: 2,
              ),
              child: MessageBubble(
                chatDocs[i]['text'],
                belongsToMe: chatDocs[i]['userId'] == userSnapshot.uid,
                userName: chatDocs[i]['userName'],
                key: ValueKey(chatDocs[i].id),
              ),
            );
          },
        );
      },
    );
  }
}
