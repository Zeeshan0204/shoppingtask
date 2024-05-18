part of 'product_bloc.dart';
@immutable
sealed class ProductEvent {
  final String category;
  final BuildContext context;
  const ProductEvent(this.context,this.category);
}

class ProductRefreshEvent extends ProductEvent {
  const ProductRefreshEvent(  super.context,super.category);
}