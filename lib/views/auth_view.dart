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
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthData authData) async {
    setState(() => _isLoading = true);

    UserCredential _userCredential;
    try {
      if (authData.isSignup) {
        _userCredential = await _auth.createUserWithEmailAndPassword(
          email: authData.email,
          password: authData.password,
        );

        final userData = {
          'name': authData.name,
          'email': authData.email,
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_userCredential.user.uid)
            .set(userData);

        print(_userCredential.user.uid);
      } else {
        _userCredential = await _auth.signInWithEmailAndPassword(
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
    } catch (err) {
      print(err);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(children: [
              AuthForm(_handleSubmit),
              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
            ]),
          ],
        ),
      ),
    );
  }
}
