part of 'category_bloc.dart';


@immutable
sealed class CategoryEvent {

  final BuildContext context;

  const CategoryEvent(this.context);
}

class CategoryRefreshEvent extends CategoryEvent {
  const CategoryRefreshEvent(  super.context);
}