part of 'category_bloc.dart';


class CategoryState extends Equatable {
  final List<CategoryModel?> category;
  String cId;

   CategoryState(
      {this.category = const <CategoryModel>[], this.cId = "1"});
  @override
  List<Object?> get props => [category, cId];

  CategoryState copyWith({
    List<CategoryModel?>? category,
    final String? cID,
  }) {
    return CategoryState(
      category: category ?? this.category,
      cId: cId,
    );
  }
}
