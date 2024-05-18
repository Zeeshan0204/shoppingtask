part of 'login_bloc.dart';


@immutable
sealed class LoginEvent {
  final String username;
  final String password;
  final BuildContext context;
  const LoginEvent(this.context,this.username,this.password);
}

class LoginRefreshEvent extends LoginEvent {
  const LoginRefreshEvent(  super.context,super.username,super.password);
}