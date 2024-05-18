part of 'product_bloc.dart';



@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> productModel;
  ProductSuccess(this.productModel);
}

class ProductError extends ProductState {
  final String errorMsg;
  ProductError(this.errorMsg);
}
