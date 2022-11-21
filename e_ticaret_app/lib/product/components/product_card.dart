import 'package:e_ticaret_app/core/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final int index;
  final ProductState state;

  const ProductCard({super.key, required this.index, required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                state.wishList[index]!.image.toString(),
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0, top: 10.0),
                child: Text(
                  state.wishList[index]!.name ?? "",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                child: Row(
                  children: [
                    Text("\$${state.wishList[index]!.price}",
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
                    Text("${state.wishList[index]!.votes}/5",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
