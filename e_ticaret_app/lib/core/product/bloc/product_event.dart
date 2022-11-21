part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

@immutable
class ProductFetched extends ProductEvent {
  final String id;
  const ProductFetched({required this.id});
}

class IsSaved extends ProductEvent {
  final ProductModel wishProduct;
  const IsSaved({required this.wishProduct});
}

class AddCart extends ProductEvent {
  final ProductModel cartProduct;
  const AddCart({required this.cartProduct});
}

class DeleteCart extends ProductEvent {
  final ProductModel cartProduct;
  const DeleteCart({required this.cartProduct});
}
