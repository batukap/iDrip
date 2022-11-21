import 'package:e_ticaret_app/product/constants/constant.dart';
import 'package:e_ticaret_app/core/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grock/grock.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.cart.isEmpty) {
            state.status = PostStatus.initial;
          } else {
            state.status = PostStatus.success;
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.failure:
              return const Center(
                child: Text("Bir Hata Oluştu"),
              );
            case PostStatus.initial:
              return const Center(
                child: Text("Henüz Sepete Bir Ürün Eklemediniz..."),
              );
            case PostStatus.success:
              return ListView(
                padding: [15, 30].horizontalAndVerticalP,
                children: [
                  ListView.separated(
                    itemCount: state.cart.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    padding: 40.verticalP,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CartContainer(index: index, state: state);
                    },
                  ),
                  PriceRow(
                    state: state,
                  ),
                  const PayButton(),
                ],
              );
          }
        },
      ),
    );
  }
}

class PriceRow extends StatelessWidget {
  final ProductState state;
  const PriceRow({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 40.onlyBottomP,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Toplam",
            style: _style,
          ),
          Text(
            "\$${state.price.toStringAsFixed(2)}",
            style: _style,
          ),
        ],
      ),
    );
  }
}

class PayButton extends StatelessWidget {
  const PayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(borderRadius: 10.allBR)),
        child: const Text(
          "Ödeme",
          style: TextStyle(
              color: Constant.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}

const TextStyle _style = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);

class CartContainer extends StatelessWidget {
  final int index;
  final ProductState state;
  const CartContainer({super.key, required this.index, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Constant.white,
          borderRadius: 10.allBR,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
            ),
          ]),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              state.cart[index]!.image.toString(),
              width: Grock.width * 0.3,
              height: Grock.width * 0.3,
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.cart[index]!.name.toString(),
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(
                    "\$ ${state.cart[index]!.price}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  context
                      .read<ProductBloc>()
                      .add(DeleteCart(cartProduct: state.cart[index]!));
                },
                icon: const Icon(Icons.clear))
          ],
        ),
      ),
    );
  }
}
