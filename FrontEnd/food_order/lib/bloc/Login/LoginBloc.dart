import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Login/LoginEvent.dart';
import 'package:food_delivery/bloc/Login/LoginState.dart';
import 'package:food_delivery/services/UserServices.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginLoadingState());
  final UserServices _userServices = UserServices();
  Stream<LoginState> _mapStartedEventToState(LoginEvent event) async* {
    yield LoginLoadingState();

    yield await _fetchAll();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginStartedEvent) {
      yield* _mapStartedEventToState(event);
      // } else if (event is LoginLoginEvent) {
      //   yield* _mapLoginEventToState(event, state);
      // } else if (event is CartCreatedEvent) {
      //   yield* _mapCreatedEventToState(event, state);
      // } else if (event is CartConfirmEvent) {
      //   yield* _mapConfirmEventToState(event, state);
      // } else if (event is CartSetAddressEvent) {
      //   yield* _mapSetAddressEventToState(event, state);
    }
  }

  Future<LoginState> _fetchAll() async {
    var cache = await _userServices.getUserAccountFromCache();
    if (cache.isSuccessed == true) {
      return LoginLoadedState(cache.payLoad!);
    }
    return LoginLoadedState(null);
  }

  // Future<LoginState> _login(LoginLoginEvent event) async {
  //   var loginResult = await _userServices.login(event.loginVM);
  //   if (loginResult.isSuccessed == true) {
  //     return LoginLoginFinishedState(
  //         loginSuccesed: loginResult.payLoad!,
  //         username: event.loginVM.username!,
  //         password: event.loginVM.password!);
  //   }
  //   return LoginLoginFinishedState(
  //       loginSuccesed: false,
  //       username: event.loginVM.username!,
  //       password: event.loginVM.password!,
  //       error: loginResult.errorMessage);
  // }
}
