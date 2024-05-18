part of 'login_bloc.dart';



@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String LoginModel;
  LoginSuccess(this.LoginModel);
}

class LoginError extends LoginState {
  final String errorMsg;
  LoginError(this.errorMsg);
}
