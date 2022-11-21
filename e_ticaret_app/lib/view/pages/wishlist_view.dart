import 'package:e_ticaret_app/core/product/bloc/product_bloc.dart';
import 'package:e_ticaret_app/product/components/product_card.dart';
import 'package:e_ticaret_app/view/detail/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.wishList.isEmpty) {
            state.wlStatus = WishListStatus.notSaved;
          } else {
            state.wlStatus = WishListStatus.saved;
          }
        },
        builder: (context, state) {
          switch (state.wlStatus) {
            case WishListStatus.notSaved:
              return const Center(
                child: Text("Henüz Bir Şey Eklemediniz..."),
              );
            case WishListStatus.saved:
              return ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: state.wishList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailView(
                                          productModel:
                                              state.product[index]!)));
                            }),
                            title: ProductCard(
                              index: index,
                              state: state,
                            ),
                          );
                        }),
                  )
                ],
              );
          }
        },
      ),
    );
  }
}
