import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  // final _auth = FirebaseAuth.instance;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Future<void> _handleSubmit(AuthData authData) async {
    try {
      if (authData.isSignup) {
        print('dentro do cadastro');
        print(authData.email + authData.password);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: authData.email,
          password: authData.password,
        );
      } else {
        print('dentro do login');
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: authData.email,
          password: authData.password,
        );
      }
    } on FirebaseAuthException catch (err) {
      final msg = err.message ?? 'Ocorreu um erro';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      print(err);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: AuthForm(_handleSubmit),
    );
  }
}
