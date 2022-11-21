import 'package:e_ticaret_app/product/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/product/bloc/product_bloc.dart';
import '../../core/product/model/product_model.dart';

class ProductDetailView extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailView({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: ProductDetailCard(
        productModel: productModel,
      ),
    );
  }
}

class ProductDetailCard extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailCard({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.035,
        ),
        ListTile(
          title: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  productModel.image.toString(),
                  height: MediaQuery.of(context).size.height * 0.6,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 30.0, top: 10.0, left: 10.0),
                  child: Text(
                    productModel.name ?? "",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, bottom: 25.0, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${productModel.price.toString()}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 20,
                      ),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          return Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<ProductBloc>()
                                    .add(AddCart(cartProduct: productModel));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange.shade900,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: const Text(
                                "Sepete Ekle",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
