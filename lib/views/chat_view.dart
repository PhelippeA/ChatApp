import 'package:chat/widgets/messages.dart';
import 'package:chat/widgets/newmessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.logout,
                          size: 26,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Logout',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (item) {
                if (item == 'logout') FirebaseAuth.instance.signOut();
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage()
          ],
        ),
      ),
    );
  }
}
