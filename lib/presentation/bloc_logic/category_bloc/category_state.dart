part of 'category_bloc.dart';



@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryModel> categoryModel;
  CategorySuccess(this.categoryModel);
}

class CategoryError extends CategoryState {
  final String errorMsg;
  CategoryError(this.errorMsg);
}
