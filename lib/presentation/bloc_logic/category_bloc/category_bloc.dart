import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertask/src/data/api_services/user_auth_api.dart';
import 'package:fluttertask/src/domain/models/category_model.dart';
import 'package:fluttertask/src/domain/models/product_model.dart';

part 'category_event.dart';
part 'category_state.dart';



class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryRefreshEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        var response = await UserAuthApis.getCategory();

        print("Response : ${response.toString()}");

        if (response != null) {
          emit(CategorySuccess(response));
        } else {
          emit(CategoryError("Something went wrong!"));

        }
      } catch (error) {
        emit(CategoryError(error.toString()));
      }
    });
  }

}