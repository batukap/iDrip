import 'package:e_ticaret_app/product/constants/constant.dart';
import 'package:e_ticaret_app/core/product/bloc/product_bloc.dart';
import 'package:e_ticaret_app/view/detail/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grock/grock.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        const Banner(),
        const Title(),
        BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state.wishList.isNotEmpty) {}
          },
          builder: (context, state) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 20,
                ),
                itemCount: state.product.length,
                padding: [20, 10, 20, 10].paddingLTRB,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return GrockContainer(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailView(
                                    productModel: state.product[index]!)));
                      }),
                      width: 150,
                      decoration: BoxDecoration(
                          color: Constant.white,
                          borderRadius: 15.allBR,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                            ),
                          ]),
                      child: HomeProductCard(
                        index: index,
                        state: state,
                      ));
                }),
              ),
            );
          },
        )
      ],
    ));
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: [20, 25, 20, 15].paddingLTRB,
      child: const Text(
        "Son Gezdiklerin",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
      child: Container(
        color: Colors.orange,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Center(
            child: Text(
          "ŞOK İNDİRİMLERİ KAÇIRMAYIN!",
          style: Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}

class HomeProductCard extends StatelessWidget {
  final int index;
  final ProductState state;
  const HomeProductCard({super.key, required this.index, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () async {
                  context.read<ProductBloc>().add(IsSaved(
                        wishProduct: state.product[index]!,
                      ));
                },
                icon: state.product[index]!.isSaved
                    ? const Icon(Icons.bookmark, color: Constant.orange)
                    : const Icon(Icons.bookmark_border_rounded,
                        color: Constant.black))
          ],
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Image.network(
            state.product[index]!.image.toString(),
          ),
        ),
        Padding(
          padding: 5.horizontalP,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  state.product[index]!.name.toString(),
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: [10, 5].horizontalAndVerticalP,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "\$${state.product[index]!.price}",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        Padding(
          padding: [10, 0].horizontalAndVerticalP,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.star_rate_rounded,
                  color: Constant.orange, size: 22),
              Text(
                "${state.product[index]!.votes}/5",
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        )
      ],
    );
  }
}
