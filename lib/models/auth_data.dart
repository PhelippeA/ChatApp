import 'dart:io';

enum AuthMode {
  Login,
  Signup,
}

class AuthData {
  String name;
  String email;
  String password;
  File image;
  AuthMode _authMode = AuthMode.Login;

  bool get isSignup {
    return _authMode == AuthMode.Signup;
  }

  toggleMode() {
    _authMode = _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
  }
}
