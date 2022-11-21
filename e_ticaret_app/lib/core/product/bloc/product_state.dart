part of 'product_bloc.dart';

enum PostStatus { initial, success, failure }

enum WishListStatus { saved, notSaved }

class ProductState extends Equatable {
  final List<ProductModel?> product;
  List<ProductModel?> cart;
  List<ProductModel?> wishList;
  final int productNumber;
  PostStatus status;
  WishListStatus wlStatus;

  double price;

  ProductState({
    this.product = const <ProductModel>[],
    this.productNumber = 0,
    this.status = PostStatus.initial,
    this.cart = const <ProductModel>[],
    this.wishList = const <ProductModel>[],
    this.price = 0.0,
    this.wlStatus = WishListStatus.notSaved,
  });
  @override
  List<Object?> get props =>
      [product, productNumber, status, cart, price, wishList, wlStatus];

  ProductState copyWith({
    List<ProductModel?>? product,
    final int? productNumber,
    PostStatus? status,
    List<ProductModel?>? cart,
    List<ProductModel?>? wishList,
    double? price,
    WishListStatus? wlstatus,
  }) {
    return ProductState(
      product: product ?? this.product,
      productNumber: productNumber ?? this.productNumber,
      status: status ?? this.status,
      cart: cart ?? this.cart,
      price: price ?? this.price,
      wishList: wishList ?? this.wishList,
      wlStatus: wlStatus,
    );
  }
}
