import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_ticaret_app/core/product/model/product_model.dart';
import 'package:e_ticaret_app/core/product/repo/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;
  ProductBloc({required this.productService}) : super(ProductState()) {
    on<ProductFetched>(_onProductFetched);
    on<IsSaved>(_onisSaved);
    on<AddCart>(_onCart);
    on<DeleteCart>(_onDeleteCart);
  }
  List<ProductModel?> products = [];
  List<ProductModel?> carts = [];
  List<ProductModel?> wishList = [];
  bool? isSave;

  FutureOr<void> _onProductFetched(
      ProductFetched event, Emitter<ProductState> emit) async {
    try {
      if (products.isEmpty) {
        products = await productService.productCall();
        final filterdata = products
            .where((element) => element!.categoryId == event.id)
            .toList();

        return emit(
            state.copyWith(product: filterdata, status: PostStatus.success));
      }
      final filterdata =
          products.where((element) => element!.categoryId == event.id).toList();

      return emit(state.copyWith(product: filterdata));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  FutureOr<void> _onisSaved(IsSaved event, Emitter<ProductState> emit) async {
    if (wishList.isEmpty) {
      event.wishProduct.isSaved = true;

      wishList.add(event.wishProduct);
      emit(state.copyWith(wishList: wishList, wlstatus: WishListStatus.saved));
    } else if (wishList.contains(event.wishProduct)) {
      event.wishProduct.isSaved = false;

      wishList.remove(event.wishProduct);
      emit(state.copyWith(
          wishList: wishList, wlstatus: WishListStatus.notSaved));
    } else {
      event.wishProduct.isSaved = true;
      wishList.add(event.wishProduct);
      emit(state.copyWith(wishList: wishList, wlstatus: WishListStatus.saved));
    }
  }

  FutureOr<void> _onCart(AddCart event, Emitter<ProductState> emit) async {
    try {
      int counter = state.productNumber + 1;

      carts.add(event.cartProduct);
      state.price =
          state.price + double.parse(event.cartProduct.price.toString());

      emit(state.copyWith(cart: carts, productNumber: counter));
    } catch (e) {
      return emit(state.copyWith(status: PostStatus.failure));
    }
  }

  FutureOr<void> _onDeleteCart(
      DeleteCart event, Emitter<ProductState> emit) async {
    state.cart.remove(event.cartProduct);
    state.price =
        state.price - double.parse(event.cartProduct.price.toString());

    if (state.cart.isEmpty) {
      return emit(state.copyWith(
          status: PostStatus.initial, productNumber: state.productNumber - 1));
    } else {
      return emit(state.copyWith(
          cart: state.cart,
          status: PostStatus.success,
          productNumber: state.productNumber - 1));
    }
  }
}
