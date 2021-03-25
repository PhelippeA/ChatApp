import 'dart:io';

import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  _submit() {
    bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      widget.onSubmit(_authData);
    }
    if (_authData.image == null && _authData.isSignup) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Precisamos da sua foto'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  void _handlePickedImage(File image) {
    _authData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (_authData.isSignup)
                      UserImagePicker(_handlePickedImage),
                    if (_authData.isSignup)
                      TextFormField(
                        initialValue: _authData.name,
                        key: ValueKey('name'),
                        decoration: InputDecoration(labelText: 'Name'),
                        onChanged: (value) => _authData.name = value,
                        validator: (value) {
                          if (value.length < 4)
                            return 'Name field must have at least 4 characters';
                          return null;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('email'),
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      onChanged: (value) => _authData.email = value,
                      validator: (value) {
                        if (!value.contains('@')) return '@ missing';
                        return null;
                      },
                    ),
                    TextFormField(
                      key: ValueKey('password'),
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Senha'),
                      onChanged: (value) => _authData.password = value,
                      validator: (value) {
                        if (value.length < 7)
                          return 'Password field must have at least 7 characters';
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                      child: Text('Entrar'),
                      onPressed: _submit,
                    ),
                    TextButton(
                      child: Text(_authData.isSignup
                          ? 'Já tem uma conta ?'
                          : 'Deseja realizar o cadastro ?'),
                      onPressed: () {
                        setState(() => _authData.toggleMode());
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
