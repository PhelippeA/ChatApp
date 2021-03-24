enum AuthMode {
  Login,
  Sigunp,
}

class AuthData {
  String name;
  String email;
  String password;
  AuthMode _authMode = AuthMode.Login;

  bool get isSignup {
    return _authMode == AuthMode.Login;
  }

  toggleMode() {
    _authMode = _authMode == AuthMode.Login ? AuthMode.Sigunp : AuthMode.Login;
  }
}
