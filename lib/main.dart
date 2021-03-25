import 'package:chat/views/auth_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/chat_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          backgroundColor: Colors.indigo[400],
          accentColor: Colors.green,
          accentColorBrightness: Brightness.light,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.black,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) 
            return ChatView();
          return AuthView();
        },
      ),
    );
  }
}
