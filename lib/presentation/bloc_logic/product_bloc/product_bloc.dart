import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertask/src/data/api_services/user_auth_api.dart';
import 'package:fluttertask/src/domain/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';



class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductRefreshEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        var response = await UserAuthApis.getProduct(category: event.category);

        print("Response : ${response.toString()}");

        if (response != null) {
          emit(ProductSuccess(response));
        } else {
          emit(ProductError("Something went wrong!"));

        }
      } catch (error) {
        emit(ProductError(error.toString()));
      }
    });
  }

}