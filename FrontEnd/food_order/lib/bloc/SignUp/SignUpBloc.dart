import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/SignUp/SignUpEvent.dart';
import 'package:food_delivery/bloc/SignUp/SignUpState.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:food_delivery/view_models/Users/ResetPasswordVM.dart';
import 'package:food_delivery/view_models/Users/RegisterRequest.dart';
import 'package:food_delivery/view_models/commons/ApiResult.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpLoadedState());
  UserServices _userServices = UserServices();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpStartedEvent) {
      yield SignUpLoadedState();
    }
  }

  Future<ApiResult<bool>> signUp(RegisterRequest registerRequest) async {
    return _userServices.register(registerRequest);
  }

  Future<ApiResult<bool>> resetPassword(ResetPasswordVM registerRequest) async {
    return _userServices.resetPassword(registerRequest);
  }

  Future<ApiResult<bool>> changePassword(
      String oldPassword, String newPassword) async {
    return _userServices.changePassword(oldPassword, newPassword);
  }
}
