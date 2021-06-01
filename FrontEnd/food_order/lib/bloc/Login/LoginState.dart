abstract class LoginState {}

class LoginLoadingState extends LoginState {}

// class LoginLoginFinishedState extends LoginState {
//   final String username;
//   final String password;
//   final bool loginSuccesed;
//   String? error;
//   LoginLoginFinishedState(
//       {required this.loginSuccesed,
//       required this.username,
//       required this.password,
//       this.error});
// }

class LoginLoadedState extends LoginState {
  LoginLoadedState(this.map);
  final Map<String, dynamic>? map;
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}
