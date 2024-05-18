import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertask/src/data/api_services/user_auth_api.dart';
import 'package:fluttertask/src/domain/models/product_model.dart';

part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRefreshEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        var response = await UserAuthApis.login(usename: event.username,password: event.password);

        print("Response : ${response.toString()}");

        if (response != null) {
          emit(LoginSuccess(response));
        } else {
          emit(LoginError("Something went wrong!"));

        }
      } catch (error) {
        emit(LoginError(error.toString()));
      }
    });
  }

}