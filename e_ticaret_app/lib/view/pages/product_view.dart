import 'package:e_ticaret_app/product/components/custom_appbar.dart';
import 'package:e_ticaret_app/view/detail/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/product/bloc/product_bloc.dart';

class ProductView extends StatefulWidget {
  final String id;
  const ProductView({super.key, required this.id});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    String pId = widget.id;
    context.read<ProductBloc>().add(ProductFetched(id: pId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: state.product.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailView(
                                        productModel: state.product[index]!)));
                          }),
                          title: ProductViewCard(
                            index: index,
                            state: state,
                          ));
                    }),
              )
            ],
          );
        },
      ),
    );
  }
}

class ProductViewCard extends StatelessWidget {
  final int index;
  final ProductState state;
  const ProductViewCard({super.key, required this.index, required this.state});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            state.product[index]!.image.toString(),
            height: MediaQuery.of(context).size.height * 0.17,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0, top: 10.0),
            child: Text(
              state.product[index]!.name ?? "",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 7.0),
            child: Row(
              children: [
                Text("\$${state.product[index]!.price}",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.orange.shade800,
                  size: 18,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text("${state.product[index]!.votes}/5",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
